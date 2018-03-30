/**
 * @file blink_green_led_dtest.cpp
 * Desktop unit tests for the blink_green_led app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include <iostream>
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "../blink_green_led_app.h"
#include "../mocks/environment.h"

using ::testing::Return;


/** Test fixture */
class BlinkGreenLedAppTest : public ::testing::Test
{
protected:
    Environment env;

    BlinkGreenLedAppTest()
    {
    }
};


/** Tests using above fixture */
TEST_F(BlinkGreenLedAppTest, InsertTestNameHere)
{
    // Insert test body here
}
