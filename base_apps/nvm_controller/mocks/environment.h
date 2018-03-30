/**
 * @file environment.h
 * Mock environment for testing the nvm_controller app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NVM_CONTROLLER_MOCK_ENVIRONMENT_H_
#define NVM_CONTROLLER_MOCK_ENVIRONMENT_H_

#include "../nvm_controller_app.h"
#include "base_apps/logger/mocks/logger_mock_app.h"
#include "gpos/hardware/boards/node_mock/board_node_mock.h"

class Environment
{
public:
    NvmControllerApp nvmController;
    LoggerMockApp logger;
    BoardNodeMock board;

    Environment()
       : nvmController(this)
    {
    } 

    void update()
    {
        nvmController.update();
    }
};


#endif  /** NVM_CONTROLLER_MOCK_ENVIRONMENT_H_ */
