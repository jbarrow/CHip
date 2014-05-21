#ifndef __LOGGER_H__
#define __LOGGER_H__

#define LOGFILE "CHip.log"
extern int log_created;

void push_to_log(char *message);
void log_error(char *message);

void push_to_log_file(char *message, char *filename);

#endif