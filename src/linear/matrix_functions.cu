#include <stdio.h>

/*
 *  Code provided by NVidia to be able to handle atomic adds
 *  for double-precision floating point numbers
 */
__device__ double atomicAdd(double* address, double val)
{
    unsigned long long int* address_as_ull =
                                          (unsigned long long int*)address;
    unsigned long long int old = *address_as_ull, assumed;
    do {
        assumed = old;
        old = atomicCAS(address_as_ull, assumed, 
                        __double_as_longlong(val + 
                        __longlong_as_double(assumed)));
    } while (assumed != old);
    return __longlong_as_double(old);
}

__global__ void cu_matrix_add(const double *d_a, const double *d_b, double *d_c, int element_count) {
    
    unsigned int x = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int y = blockIdx.y * blockDim.y + threadIdx.y;
    int tid = x * y + x;

    while( tid < element_count ) {
        d_c[tid] = d_a[tid] + d_b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

__global__ void cu_matrix_sub(const double *d_a, const double *d_b, double *d_c, int element_count) {
    unsigned int x = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int y = blockIdx.y * blockDim.y + threadIdx.y;
    int tid = x * y + x;

    while( tid < element_count ) {
        d_c[tid] = d_a[tid] - d_b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

__global__ void cu_element_mul(const double *d_a, const double *d_b, double *d_c, int element_count) {
    unsigned int x = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int y = blockIdx.y * blockDim.y + threadIdx.y;
    int tid = x * y + x;

    while( tid < element_count ) {
        d_c[tid] = d_a[tid] * d_b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

__global__ void cu_element_div(const double *d_a, const double *d_b, double *d_c, int element_count) {
    unsigned int x = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int y = blockIdx.y * blockDim.y + threadIdx.y;
    int tid = x * y + x;

    while( tid < element_count ) {
        d_c[tid] = d_a[tid] / d_b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

static void handleError( cudaError_t err, const char* file, int line ) {
    if(err != cudaSuccess) {
        printf("%s (%d): %s", file, line, cudaGetErrorString(err));
        exit( EXIT_FAILURE );
    }
}