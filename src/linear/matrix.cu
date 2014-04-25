#include "matrix_functions.cu"
#include <stdlib.h>

extern "C" {
	#include "matrix.h"
}

__global__ void cu_matrix_add(const double *d_a, const double *d_b, double *d_c, int element_count);
static void handleError( cudaError_t err, const char *file, int line );

extern "C"
c_matrix *new_c_matrix(int i, int j) {
	c_matrix *m = (c_matrix *)malloc(sizeof(*m));
	if(m == NULL)
		return NULL;

	m->data = (double *)malloc(sizeof(double) * i * j);
	if(m->data == NULL) {
		free(m);
		return NULL;
	}

	m->n = i;
	m->m = j;

	return m;
}

extern "C"
void del_c_matrix(c_matrix *m) {
	if( m != NULL ) {
		free(m->data);
		free(m);
	}
}

extern "C"
double c_matrix_get(c_matrix *m, int i, int j) {
	/* 	Ideally if we reach this point, we could raise an error;
	 *	Still trying to figure out how to handle errors in C */
	if(i > m->n || j > m->m || i < 1 || j < 1)
		return NULL;
	return m->data[(i-1) * (j-1) + (j-1)];
}

/*
 *	Set a specific element to a specific value, with index
 *	checking.
 */
extern "C"
void c_matrix_set(c_matrix *m, int i, int j, double value) {
	if(i > m->n || j > m->m || i < 1 || j < 1)
		exit(EXIT_FAILURE);
	m->data[(i-1) * (j-1) + (i-1)] = value;
}

/*	Initialize a matrix with all zero's */
extern "C"
void zeros(c_matrix *m) {
	/* memcpy(m->data, 0, sizeof(double) * m->m * m->n); */
	int i;
	for(i = 0; i < m->m * m->n; ++i)
		m->data[i] = 0.0;
}

/*	Initialize a matrix with all one's */
extern "C"
void ones(c_matrix *m) {
	int i;
	for(i = 0; i < m->m * m->n; ++i)
		m->data[i] = 1.0;
}

/*
 *	Initializes the matrix with random numbers defined
 *	over the interval (a, b]
 */
extern "C"
void c_matrix_rand(c_matrix *m1, double a, double b) {}

/*
 *	Takes in a function pointer representing a specific
 *	distribution that returns a random double. In neural
 *	networks, it is sometimes favorable to intitialize
 *	a matrix with a t-distribution
 */
extern "C"
void c_matrix_dist(c_matrix *m1, double (*init)()) {}

/*	Add two matrices and store the result in a third */
extern "C"
void c_matrix_add(const c_matrix *m1, const c_matrix *m2, c_matrix *m) {
	/*	We only need 4 comparisons because we can assume
	 *	transitivity of ints */
	if(m1->m != m2->m || m1->n != m2->n || m1->m != m->m
		|| m1->n != m2->n)
		exit(EXIT_FAILURE);

	double *d_a, *d_b, *d_c;
	handle_error( cudaMalloc((void**)&d_a, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_b, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_c, m1->m * m1->n * sizeof(double)) );

	handle_error( cudaMemcpy(d_a, m1->data, m1->m * m1->n * sizeof(double), cudaMemcpyHostToDevice ) );
	handle_error( cudaMemcpy(d_b, m2->data, m2->m * m2->n * sizeof(double), cudaMemcpyHostToDevice ) );

	cu_matrix_add<<< 32, (m1->m * m1->n + 31)/32 >>>(d_a, d_b, d_c, m1->m * m1->n);

	handle_error( cudaMemcpy(m->data, d_c, m2->m * m2->n * sizeof(double), cudaMemcpyDeviceToHost ) );

	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
}

/*	Subtract two matrices and store the result in a third */
extern "C"
void c_matrix_sub(const c_matrix *m1, const c_matrix *m2, c_matrix *m) {
	if(m1->m != m2->m || m1->n != m2->n || m1->m != m->m
		|| m1->n != m2->n)
		exit(EXIT_FAILURE);

	double *d_a, *d_b, *d_c;
	handle_error( cudaMalloc((void**)&d_a, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_b, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_c, m1->m * m1->n * sizeof(double)) );

	handle_error( cudaMemcpy(d_a, m1->data, m1->m * m1->n * sizeof(double), cudaMemcpyHostToDevice ) );
	handle_error( cudaMemcpy(d_b, m2->data, m2->m * m2->n * sizeof(double), cudaMemcpyHostToDevice ) );

	cu_matrix_sub<<< 32, (m1->m * m1->n + 31)/32 >>>(d_a, d_b, d_c, m1->m * m1->n);

	handle_error( cudaMemcpy(m->data, d_c, m2->m * m2->n * sizeof(double), cudaMemcpyDeviceToHost ) );

	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
}

/*	Element-wise multiply two matrices and store the result in a third */
extern "C"
void c_element_mul(const c_matrix *m1, const c_matrix *m2, c_matrix *m) {
	if(m1->m != m2->m || m1->n != m2->n || m1->m != m->m
		|| m1->n != m2->n)
		exit(EXIT_FAILURE);

	double *d_a, *d_b, *d_c;
	handle_error( cudaMalloc((void**)&d_a, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_b, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_c, m1->m * m1->n * sizeof(double)) );

	handle_error( cudaMemcpy(d_a, m1->data, m1->m * m1->n * sizeof(double), cudaMemcpyHostToDevice ) );
	handle_error( cudaMemcpy(d_b, m2->data, m2->m * m2->n * sizeof(double), cudaMemcpyHostToDevice ) );

	cu_element_mul<<< 32, (m1->m * m1->n + 31)/32 >>>(d_a, d_b, d_c, m1->m * m1->n);

	handle_error( cudaMemcpy(m->data, d_c, m2->m * m2->n * sizeof(double), cudaMemcpyDeviceToHost ) );

	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
}

/*	Element-wise divide two matrices and store the result in a third */
extern "C"
void c_element_div(const c_matrix *m1, const c_matrix *m2, c_matrix *m) {
	if(m1->m != m2->m || m1->n != m2->n || m1->m != m->m
		|| m1->n != m2->n)
		exit(EXIT_FAILURE);

	double *d_a, *d_b, *d_c;
	handle_error( cudaMalloc((void**)&d_a, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_b, m1->m * m1->n * sizeof(double)) );
	handle_error( cudaMalloc((void**)&d_c, m1->m * m1->n * sizeof(double)) );

	handle_error( cudaMemcpy(d_a, m1->data, m1->m * m1->n * sizeof(double), cudaMemcpyHostToDevice ) );
	handle_error( cudaMemcpy(d_b, m2->data, m2->m * m2->n * sizeof(double), cudaMemcpyHostToDevice ) );

	cu_element_div<<< 32, (m1->m * m1->n + 31)/32 >>>(d_a, d_b, d_c, m1->m * m1->n);

	handle_error( cudaMemcpy(m->data, d_c, m2->m * m2->n * sizeof(double), cudaMemcpyDeviceToHost ) );

	cudaFree( d_a );
	cudaFree( d_b );
	cudaFree( d_c );
}