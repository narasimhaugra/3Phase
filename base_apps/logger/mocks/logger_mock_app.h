/**
 * @file logger_mock_app.h
 * Mock (gmock) of logger app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef LOGGER_MOCK_APP_H_
#define LOGGER_MOCK_APP_H_

#include "gmock/gmock.h"
#include "../logger_api.h"



class LoggerMockApp : Logger_API
{
public:
    // MOCK METHODS GO HERE
	MOCK_METHOD0(update, void());
	MOCK_METHOD1(print, bool(char *message));
};


#endif  /** LOGGER_MOCK_APP_H_ */
