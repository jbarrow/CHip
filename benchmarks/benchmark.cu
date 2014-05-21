#include <stdio.h>
#include <time.h>

extern "C" {
	#include "../src/logger.h"
	#include "../src/linear/matrix.h"
}

#define NUM_MATRICES 3

static int timestamp = 0;
static char filename[20];

char* get_filename() {
	if(timestamp == 0) {
		timestamp = (int)time(NULL);
		sprintf(filename, "benchmark_%d.csv", timestamp);
	}

	return filename;
}

/*
 *	Initialize the benchmark variable, which will propogate
 *	through the implementation code.
 */
int main() {
	/* Initialize matrix values */
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);

	float elapsed_time;
	char content[200];
	c_matrix* matrices[3*NUM_MATRICES];

	/* Loop through matrix sizes and create matrices */
	int i;
	unsigned int j = 1;
	for(i = 0; i < NUM_MATRICES; ++i) {
		matrices[3*i] = new_c_matrix(j, j);
		matrices[3*i+1] = new_c_matrix(j, j);
		matrices[3*i+2] = new_c_matrix(j, j);
		j = j << 1;
	}
	
	/* Create the CSV header for our benchmark spreadsheet */
	sprintf(content, "Operation, Matrix Size, Time Taken (ms)\n");
	push_to_log_file(content, get_filename());

	/* Matrix Initialization */
	j = 1;
	for(i = 0; i < NUM_MATRICES; ++i) {
		cudaEventRecord(start, 0);

		ones(matrices[3*i]);

		cudaEventRecord(stop, 0);
		cudaEventSynchronize(stop);
		cudaEventElapsedTime(&elapsed_time, start, stop);
		sprintf(content, "Initialize to 1, %d, %f\n", j, elapsed_time);
		push_to_log_file(content, get_filename());
		j = j << 1;
	}

	/* Matrix Initialization */
	j = 1;
	for(i = 0; i < NUM_MATRICES; ++i) {
		cudaEventRecord(start, 0);

		zeros(matrices[3*i+1]);

		cudaEventRecord(stop, 0);
		cudaEventSynchronize(stop);
		cudaEventElapsedTime(&elapsed_time, start, stop);
		sprintf(content, "Initialize to 0, %d, %f\n", j, elapsed_time);
		push_to_log_file(content, get_filename());
		j = j << 1;
	}

	/* Matrix Addition */
	j = 1;
	for(i = 0; i < NUM_MATRICES; ++i) {
		cudaEventRecord(start, 0);

		c_matrix_add(matrices[3*i], matrices[3*i+1], matrices[3*i+2]);

		cudaEventRecord(stop, 0);
		cudaEventSynchronize(stop);
		cudaEventElapsedTime(&elapsed_time, start, stop);
		sprintf(content, "Add Two Matrices, %d, %f\n", j, elapsed_time);
		push_to_log_file(content, get_filename());
		j = j << 1;
	}
	

	return(EXIT_SUCCESS);
}