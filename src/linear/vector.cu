#include "vector_functions.cu"
#include <stdlib.h>

extern "C" {
	#include "vector.h"
}

extern "C"
c_matrix *new_c_vector(int size, vector_t type) {
	int n = type == ROW_VECTOR ? 1 : size;
	int m = type == ROW_VECTOR ? size : 1;

	return new_c_matrix(n, m);
}