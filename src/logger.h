#ifndef __LOGGER_H__
#define __LOGGER_H__

#define LOGFILE "CHip.log"
extern int log_created;

void push_to_log(char *message);
void log_error(char *message);

#endif