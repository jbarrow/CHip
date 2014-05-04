#ifndef NETWORK_H
#define NETWORK_H

#include "../linear/matrix.h"

typedef struct {
	int layers;
	int* layer_counts;
	c_matrix* weights;
} n_network;

#endif