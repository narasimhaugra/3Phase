/**
 * @file environment.h
 * Mock environment for testing the logger app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef LOGGER_MOCK_ENVIRONMENT_H_
#define LOGGER_MOCK_ENVIRONMENT_H_

#include "../logger_app.h"
#include "gpos/hardware/boards/node_mock/board_node_mock.h"


class Environment
{
public:
    LoggerApp logger;
    BoardNodeMock board;
   
    Environment()
       : logger(this)
    {
    } 

    void update()
    {
        logger.update();
    }
};


#endif  /** LOGGER_MOCK_ENVIRONMENT_H_ */
