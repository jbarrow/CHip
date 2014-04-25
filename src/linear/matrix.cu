#include "matrix_functions.cu"
#include <stdlib.h>

extern "C" {
	#include "matrix.h"
}

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
	int i;
	for(i = 0; i < m1->m * m1->n; ++i)
		m->data[i] = m1->data[i] + m2->data[i];
}