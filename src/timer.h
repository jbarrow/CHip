#ifndef TIMER_H
#define TIMER_H

#include <stdlib.h>
#include <sys/time.h>

struct timeval timerStart;

void start_time() {
	gettimeofday(&timerStart, NULL);
}

double get_time() {
	struct timeval timerStop, timerElapsed;
	gettimeofday(&timerStop, NULL);
	timersub(&timerStop, &timerStart, &timerElapsed);
	return timerElapsed.tv_sec*1000.0 + timerElapsed.tv_usec/1000.0;
}

#endif