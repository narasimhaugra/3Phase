/**
 * @file ui_api.h
 * A generic ui API
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef UI_API_H_
#define UI_API_H_

#include "gpos/application.h"
#include "gpos/utils/time/stop_watch.h"
#include <stdint.h>

typedef uint16_t ui_state_t;

APP_API(Ui_API)
	/**
	 * [Description of API method.]
     *
     * @param [param_name] [description of parameter]
     * @return [description of return value]
     */
	//virtual type_t method(type_t param_name) = 0;
ENDAPP_API


#endif  /** UI_API_H_ */
