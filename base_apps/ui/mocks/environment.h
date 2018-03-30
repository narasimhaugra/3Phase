/**
 * @file environment.h
 * Mock environment for testing the ui app.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef UI_MOCK_ENVIRONMENT_H_
#define UI_MOCK_ENVIRONMENT_H_

#include "../ui_app.h"


class Environment
{
public:
    UiApp INSERT_APP_INSTANCE_NAME;
   
    Environment()
       : INSERT_APP_INSTANCE_NAME(this)
    {
    } 

    void update()
    {
        INSERT_APP_INSTANCE_NAME.update();
    }
};


#endif  /** UI_MOCK_ENVIRONMENT_H_ */
