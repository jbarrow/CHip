#ifndef VECTOR_H
#define VECTOR_H

#include "matrix.h"

c_matrix* new_c_vector(int size);
void del_c_matrix(c_matrix* m);

double c_vector_get(c_matrix* m, int i);
void c_vector_set(c_matrix* m, int i, double value);

int check_vector(c_matrix* m);
double c_dot_product(const c_matrix* v1, const c_matrix* v2);

#endif