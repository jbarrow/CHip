#include <stdio.h>
#include "../src/timer.h"
#include "../src/linear/matrix.h"

int main() {
	c_matrix *l1 = new_c_matrix(2048, 2048);
	c_matrix *l2 = new_c_matrix(2048, 2048);
	c_matrix *l3 = new_c_matrix(2048, 2048);
	double timeval;

	start_time();
	ones(l1);
	ones(l2);
	timeval = get_time();

	printf("\nTime to clear out two 2048x2048 matrices: %f\n", timeval);
	
	/*
	start_time();
	c_matrix_add(l1, l2, l3);
	timeval = get_time();

	printf("Time to add out two 2048x2048 matrices: %f\n", timeval);
	*/
	
	return(EXIT_SUCCESS);
}