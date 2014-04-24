#ifndef MATRIX_H
#define MATRIX_H

/*
 *	Define the implementation for a matrix. Matrices store
 *	data in double-precision floating point form; MATLAB
 *	stores floating point numbers with the same precision,
 *	and we want to be able to run simulations with the
 *	exact same parameters.
 */

typedef struct {
	int n, m; /* Define an n-rows by m-columns matrix */
	double* data; /* Data stored in row-major form */
} c_matrix;

/* c_matrix memory management functions */
c_matrix *new_c_matrix(int i, int j);
void del_c_matrix(c_matrix* m);

/* matrices initialized to special values */
c_matrix *zeros(int i, int j);
c_matrix *ones(int i, int j);
c_matrix *c_matrix_rand(int i, int j);
c_matrix *c_matrix_dist(int i, int j, double (*init)());



#endif