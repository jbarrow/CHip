/*
 *	Define the implementation for a vector. The Chip linear 
 *	library treats vectors as matrices. The check_vector
 *	method is a simple method for determining whether a matrix
 *	can be considered a vector or not.
 */

#ifndef VECTOR_H
#define VECTOR_H

#include "matrix.h"

typedef enum { ROW_VECTOR, COLUMN_VECTOR } vector_t;

c_matrix* new_c_vector(int size, vector_t type);
void del_c_matrix(c_matrix* m);

double c_vector_get(c_matrix* m, int i);
void c_vector_set(c_matrix* m, int i, double value);

int check_vector(c_matrix* m);
double c_dot_product(const c_matrix* v1, const c_matrix* v2);

#endif