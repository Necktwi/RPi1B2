#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable
__kernel void test_thread_dimension_atomic(__global uint *dst, 
         uint final_x_size,   uint final_y_size,   uint final_z_size,
         uint start_address,  uint end_address)
{
    uint error = 0;
           if (get_global_id(0) >= final_x_size)
               error = 64;
           if (get_global_id(1) >= final_y_size)
               error = 128;
           if (get_global_id(2) >= final_z_size)
               error = 256;

       unsigned int t_address = (unsigned int)get_global_id(2)*(unsigned int)final_y_size*(unsigned int)final_x_size + 
               (unsigned int)get_global_id(1)*(unsigned int)final_x_size + (unsigned int)get_global_id(0);
       if ((t_address >= start_address) && (t_address < end_address))
               atom_add(&dst[t_address-start_address], 1u);
       if (error)
               atom_or(&dst[t_address-start_address], error);

}

__kernel void clear_memory(__global uint *dst)

{
           dst[get_global_id(0)] = 0;

}

