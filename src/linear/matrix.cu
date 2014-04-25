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
		Still trying to figure out how to handle errors in C */
	if(i > m->n || j > m->m || i < 1 || j < 1)
		return NULL;
	return m->data[(i-1) * (j-1) + (j-1)];
}

extern "C"
void c_matrix_set(c_matrix *m, int i, int j, double value) {
	if(i > m->n || j > m->m || i < 1 || j < 1)
		return;
	m->data[(i-1) * (j-1) + (i-1)] = value;
}

extern "C"
void zeros(c_matrix *m) {
	int i;
	for(i = 0; i < m->m * m->n; ++i)
		m->data[i] = 0.0;
}

extern "C"
void ones(c_matrix *m) {
	int i;
	for(i = 0; i < m->m * m->n; ++i)
		m->data[i] = 1.0;
}