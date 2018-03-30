/**
 * @file nvm_controller_api.h
 * Saves and restores non-volatile data of apps
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NVM_CONTROLLER_API_H_
#define NVM_CONTROLLER_API_H_

#include "gpos/application.h"
#include "base_apps/nvm_controller/nvm_accessor.h"


APP_API(NvmController_API)
	/**
	 * Register an NVM Accessor with the controller.
     *
     * @param accessor The accessor to register.
     * @return true if accessor was registered successfully, false otherwise.
     */
	virtual bool registerAccessor(NVM_Accessor *accessor) = 0;
ENDAPP_API


#endif  /** NVM_CONTROLLER_API_H_ */
