/**
 * @file nvm_controller_mock_app.h
 * Mock (gmock) of nvm_controller app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NVM_CONTROLLER_MOCK_APP_H_
#define NVM_CONTROLLER_MOCK_APP_H_

#include "gmock/gmock.h"
#include "../nvm_controller_api.h"


class MockEnvironment;

class NvmControllerMockApp : NvmController_API
{
    friend class MockEnvironment;

public:
      MOCK_METHOD0(update, void());
      MOCK_METHOD1(registerAccessor, bool(NVM_Accessor *accessor));
};


#endif  /** NVM_CONTROLLER_MOCK_APP_H_ */
