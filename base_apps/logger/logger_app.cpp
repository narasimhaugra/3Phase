/**
 * @file logger_app.cpp
 * Allows apps to print messages to a logging terminal.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "logger_app.h"
#include "environment.h"


CONSTRUCT(LoggerApp)
	, _log(&(env->board.externalFlash), LOG_FLASH_START_ADDRESS, LOG_NUM_SECTORS, LOG_ENTRY_SIZE)
	,flashValidated(false)
{
}


UPDATE(LoggerApp)
{
	
}


bool LoggerApp::print(char *message, uint8_t len)
{
  if(flashValidated )
  {
	char logMessage[LOG_ENTRY_SIZE];
	datetime_t now;
	while(!env->board.rtc.getDatetime(now));
	memcpy(logMessage, (uint8_t*)&now, LOG_DATETIME_SIZE);

	if(len > LOG_MESSAGE_SIZE)
	{
		return false;
	}

	for(uint8_t i=LOG_DATETIME_SIZE; i<LOG_ENTRY_SIZE; i++)
	{
		logMessage[i] = message[i-LOG_DATETIME_SIZE];
	}
	for(uint8_t i=len+LOG_DATETIME_SIZE; i<LOG_ENTRY_SIZE; i++)
	{
		logMessage[i] = '\0';
	}

	_log.putEntry((uint8_t*)logMessage, LOG_ENTRY_SIZE);
	return true;
  }
  return false;
}

bool LoggerApp::print(char *message, uint8_t len, int32_t val)
{
	if(flashValidated )
	{
		char logMessage[LOG_ENTRY_SIZE];
		datetime_t now;
		int len1 = 0;

		while(!env->board.rtc.getDatetime(now));
		memcpy(logMessage, (uint8_t*)&now, LOG_DATETIME_SIZE);

		if(len > LOG_MESSAGE_INT32_SIZE)
		{
			return false;
		}

		// Check whether the integer value to be logged is negative
		if (val<0)
		{
			// Convert the negative integer value to a uint32_t by multiplying by -1.
			uint32_t _temp = val*(-1);
			uint32_t _dividerValue = 1;

			for(uint8_t i=LOG_DATETIME_SIZE; i<LOG_MESSAGE_INT32_SIZE; i++)
			{
				logMessage[i] = message[i-LOG_DATETIME_SIZE];
			}

			// Add a negative sign at the beginning of the negative integer entry
			logMessage[32] = '-';

			// flag is used to check whether any leading zeros are present in the integer value
			int flag = 0;

			// j counts the number of trailing zeros, to remove them from the character array
			int j=0;

			// Convert the uint32_t value to a character array
			for(uint8_t i=0;i<10;i++)
			{
				logMessage[33+i-j] = (_temp/(1000000000/(_dividerValue))) + 48;

				if ((logMessage[33+i-j] == '0') && (flag != 1))
				{
					j++;
				}
				else
				{
					flag = 1;
				}

				_temp = _temp%(1000000000/(_dividerValue));
				_dividerValue = _dividerValue*10;

				// len1 stores the length of the integer-to-character converted array
				len1 = i-j+2;
			}
		}

		// Check whether the integer value to be logged is positive
		else if (val>=0)
		{
			// No conversion needed for a positive integer input
			uint32_t _temp = val;
			uint32_t _dividerValue = 1;

			for(uint8_t i=LOG_DATETIME_SIZE; i<LOG_MESSAGE_INT32_SIZE; i++)
			{
				logMessage[i] = message[i-LOG_DATETIME_SIZE];
			}

			// flag is used to check whether any leading zeros are present in the integer value
			int flag = 0;

			// j counts the number of trailing zeros, to remove them from the character array
			int j=0;

			// Convert the uint32_t value to a character array
			for(uint8_t i=0;i<10;i++)
			{
				logMessage[32+i-j] = (_temp/(1000000000/(_dividerValue))) + 48;

				if ((logMessage[32+i-j] == '0') && (flag != 1))
				{
					j++;
				}
				else
				{
					flag = 1;
				}

				_temp = _temp%(1000000000/(_dividerValue));
				_dividerValue = _dividerValue*10;

				// len1 stores the length of the integer-to-character converted array
				len1 = i-j+1;
			}
		}

		for(uint8_t i=LOG_DATETIME_SIZE; i<LOG_MESSAGE_INT32_SIZE; i++)
		{
			logMessage[i] = message[i-LOG_DATETIME_SIZE];
		}

		for(uint8_t i=len+len1+LOG_DATETIME_SIZE; i<LOG_ENTRY_SIZE; i++)
		{
			logMessage[i] = '\0';
		}

		_log.putEntry((uint8_t*)logMessage, LOG_ENTRY_SIZE);
		return true;
	}
	return false;
}

bool LoggerApp::getNewest(uint8_t* buffer, uint16_t len)
{
	return _log.getTail(buffer, len);
}


bool LoggerApp::getOldest(uint8_t* buffer, uint16_t len)
{
	return _log.getHead(buffer, len);
}


uint32_t LoggerApp::getNumEntries()
{
	return _log.getNumEntries();
}

void LoggerApp::clear()
{
	return _log.clear();
}
