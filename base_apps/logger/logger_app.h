/**
 * @file logger_app.h
 * Allows apps to print messages to a logging terminal.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef LOGGER_APP_H_
#define LOGGER_APP_H_

#include <string.h>
#include <stdint.h>
#include "logger_api.h"
#include "gpos/utils/circular_log/circular_log.h"


#define LOG_ENTRY_SIZE 42 /*< The size of each log entry. This includes the timestamp as well as the message */
#define LOG_MESSAGE_SIZE 34 /*< Size of the message within each log entry */
#define LOG_DATETIME_SIZE 8 /*< Size of timestamp within each log entry. This is essentially equal to sizeof(datetime_t) */
#define LOG_NUM_SECTORS 4 /*< Number of 4kB sectors reserved in external flash memory for logging purpose */
#define LOG_FLASH_START_ADDRESS 0x6A000 /*< Address in external flash where log entries are stored */

#define LOG_MESSAGE_INT32_SIZE 32 /* Size of message within each log entry that has an integer entry as well */
#define LOG_INT32_SIZE 10 /* Size of integer value being logged */

APP(LoggerApp, Logger_API)
private:

	CircularLog _log;

	bool flashValidated;

public:
	/**
	 * Print a message to the logging terminal.
	 *
	 * Note that in the current implementation the message source is not
	 * automatically added to the log, so it would be wise for users of
	 * this function to include their own name in the message.
	 *
	 * @param message Pointer to the message to print to the log.
	 *
	 * @param len Length of the message array.
	 *
	 * @return true if message was successfully printed, false otherwise.
	 */
	bool print(char *message, uint8_t len);


	/**
	 * Print a message, along with an int32_t integer, to the logging terminal.
	 *
	 * Note that in the current implementation the message source is not
	 * automatically added to the log, so it would be wise for users of
	 * this function to include their own name in the message.
	 *
	 * @param message Pointer to the message to print to the log.
	 *
	 * @param len Length of the message array.
	 *
	 * @param val The integer value to be logged along with the message.
	 *
	 * @return true if message was successfully printed, false otherwise.
	 */
	bool print(char *message, uint8_t len, int32_t val);


	/**
	 * This function is used to retrieve the latest log entry
	 *
	 * @param buffer is the pointer in the memory which is to be populated with
	 * the latest log entry
	 *
	 * @param len is the number of bytes which is to be filled into buffer. This field should
	 * almost always be the same as LOG_ENTRY_SIZE macro
	 *
	 * @return false if no entries exist in the log; true otherwise
	 */
	bool getNewest(uint8_t* buffer, uint16_t len);


	/**
	 *
	 * This function is used to retrieve the oldest log entry
	 * (ie, the first log entry after clear() was last called)
	 *
	 * @param len is the number of bytes which is to be filled into buffer. This field should
	 * almost always be the same as LOG_ENTRY_SIZE macro
	 *
	 * @param buffer is the pointer in the memory which is to be populated with
	 * the oldest log entry
	 *
	 * @return false if no entries exist in the log; true otherwise
	 */
	bool getOldest(uint8_t* buffer, uint16_t len);


	/**
	 * @return the number of log entries present in external flash. Each call to print() increments
	 * the number of log entries; while a call to the clear() function deletes all log entries
	 * (=> if getNumEntries is called immediately after clear(), then the value 0 would be returned)
	 */
	uint32_t getNumEntries();

	/**
	 * Clears all log entries from external flash and resets the meta data.
	 * Once this function is executed, all the getNumEntries() method should
	 * return 0
	 */
	void clear();

ENDAPP


#endif  /** LOGGER_APP_H_ */
