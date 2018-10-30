__kernel void test_pointer_cast(__global unsigned char *src, __global unsigned int *dst)
{
    int          tid = get_global_id(0);
    __global unsigned int *p = (__global unsigned int *)src;

    dst[tid] = p[tid];

}
