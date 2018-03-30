/**
 * @file environment.h
 * Mock environment for testing the net app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NET_MOCK_ENVIRONMENT_H_
#define NET_MOCK_ENVIRONMENT_H_

#include "../net_app.h"
#include "base_apps/logger/mocks/logger_mock_app.h"


class Environment
{
public:
    NetApp net;
    LoggerMockApp logger;

    Environment()
       : net(this)
    {
    } 

    void update()
    {
        net.update();
    }
};


#endif  /** NET_MOCK_ENVIRONMENT_H_ */
