/**
 * @file environment.h
 * Mock environment for testing the blink_green_led app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef BLINK_GREEN_LED_MOCK_ENVIRONMENT_H_
#define BLINK_GREEN_LED_MOCK_ENVIRONMENT_H_

#include "../blink_green_led_app.h"
#include "gpos/hardware/boards/node_mock/board_node_mock.h"
#include "base_apps/logger/mocks/logger_mock_app.h"

class Environment
{
public:
    BoardNodeMock board;
    BlinkGreenLedApp blink;
    LoggerMockApp logger;

    Environment()
       : blink(this)
    {
    } 

    void update()
    {
        blink.update();
    }
};


#endif  /** BLINK_GREEN_LED_MOCK_ENVIRONMENT_H_ */
