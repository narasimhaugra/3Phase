/**
 * @file net_dtest.cpp
 * Desktop unit tests for the net app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include <iostream>
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "../net_app.h"
#include "../mocks/environment.h"

using ::testing::Return;


/** Test fixture */
class NetAppTest : public ::testing::Test
{
protected:
    Environment env;

    NetAppTest()
    {
    }
};


/** Tests using above fixture */
TEST_F(NetAppTest, InsertTestNameHere)
{
    // Insert test body here
}
