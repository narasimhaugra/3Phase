/**
 * @file logger_api.h
 * Allows apps to print messages to a logging terminal.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef LOGGER_API_H_
#define LOGGER_API_H_

#include "gpos/application.h"


APP_API(Logger_API)
	/**
	 * Print a message to the logging terminal.
	 *
	 * @param message Pointer to the message to print to the log.
	 *
	 * @return true if message was successfully printed, false otherwise.
	 */
	virtual bool print(char *message, uint8_t len) = 0;
ENDAPP_API


#endif  /** LOGGER_API_H_ */
