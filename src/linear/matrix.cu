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