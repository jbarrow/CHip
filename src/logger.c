#include <stdlib.h>
#include <stdio.h>
#include "logger.h"

int log_created = 0;

void push_to_log(char *message) {
	FILE *file;

	if(0 == log_created) {
		file = fopen(LOGFILE, "w");
		log_created = 1;
	} else
		file = fopen(LOGFILE, "a");

	if(NULL == file) {
		if(log_created)
			log_created = 0;
		return;
	} else {
		fputs(message, file);
		fclose(file);
	}

	if(file)
		fclose(file);
}

void log_error(char *message) {
	push_to_log(message);
	push_to_log("\n");
	printf("*** There was an error, exiting. Check the logs for details. ***\n");
	exit(EXIT_FAILURE);
}