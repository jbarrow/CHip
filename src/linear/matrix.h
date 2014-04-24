/*
 *	Define the implementation for a matrix. Matrices store
 *	data in double-precision floating point form; MATLAB
 *	stores floating point numbers with the same precision,
 *	and we want to be able to run simulations with the
 *	exact same parameters.
 */

#ifndef MATRIX_H
#define MATRIX_H

typedef struct {
	int n, m; /* Define an n-rows by m-columns matrix */
	double* data; /* Data stored in row-major form */
} c_matrix;

/* c_matrix memory management functions */
c_matrix *new_c_matrix(int i, int j);
void del_c_matrix(c_matrix* m);

double c_matrix_get(int i, int j);
void c_matrix_set(int i, int j, double val);

void zeros(c_matrix* m);
void ones(c_matrix* m);
void c_matrix_rand(c_matrix* m);
void c_matrix_dist(c_matrix* m, double (*init)());

void c_matrix_add(const c_matrix* m1, const c_matrix* m2, c_matrix* m);
void c_matrix_sub(const c_matrix* m1, const c_matrix* m2, c_matrix* m);
void c_matrix_mul(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

void c_scalar_add(const c_matrix* m, double d, c_matrix* m_dest);
void c_scalar_mul(const c_matrix* m, double d, c_matrix* m_dest);

void c_matrix_transpose(const c_matrix* m, c_matrix* m_prime);

#endif