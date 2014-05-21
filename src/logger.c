#include <stdlib.h>
#include <stdio.h>
#include "logger.h"

#define DISPLAY_LOG 1
int log_created = 0;

void push_to_log(char *message) {
	push_to_log_file(message, LOGFILE);
}

void push_to_log_file(char *message, char* filename) {
	FILE *file;

	if(0 == log_created) {
		file = fopen(filename, "w");
		log_created = 1;
	} else
		file = fopen(filename, "a");

	if(NULL == file) {
		if(log_created)
			log_created = 0;
		return;
	} else {
		fputs(message, file);
		fclose(file);
	}

	if(DISPLAY_LOG)
		printf("%s", message);

	if(file)
		fclose(file);
}

void log_error(char *message) {
	push_to_log(message);
	push_to_log("\n");
	printf("*** There was an error, exiting. Check the logs for details. ***\n");
	exit(EXIT_FAILURE);
}