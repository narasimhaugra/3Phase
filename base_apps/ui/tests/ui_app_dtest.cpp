/**
 * @file ui_dtest.cpp
 * Desktop unit tests for the ui app.
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
#include "../ui_app.h"
#include "../mocks/environment.h"

using ::testing::Return;


/** Test fixture */
class UiAppTest : public ::testing::Test
{
protected:
    Environment env;

    UiAppTest()
    {
    }
};


/** Tests using above fixture */
TEST_F(UiAppTest, InsertTestNameHere)
{
    // Insert test body here
}
