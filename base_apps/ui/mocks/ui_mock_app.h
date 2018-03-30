/**
 * @file ui_mock_app.h
 * Mock (gmock) of ui app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef UI_MOCK_APP_H_
#define UI_MOCK_APP_H_

#include "gmock/gmock.h"
#include "../ui_api.h"


class MockEnvironment;

class UiMockApp : Ui_API
{
    friend class MockEnvironment;

public:
    // MOCK METHODS GO HERE
};


#endif  /** UI_MOCK_APP_H_ */
