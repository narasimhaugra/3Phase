/**
 * @file logger_dtest.cpp
 * Desktop unit tests for the logger app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#define CATCH_CONFIG_MAIN
#include <iostream>
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "../logger_app.h"
#include "../mocks/environment.h"

using ::testing::Return;


/** Test fixture */
class LoggerAppTest : public ::testing::Test
{
protected:
    Environment env;

    LoggerAppTest()
    {
    }
};


/** Tests using above fixture */
TEST_F(LoggerAppTest, InsertTestNameHere)
{
    // Insert test body here
}
