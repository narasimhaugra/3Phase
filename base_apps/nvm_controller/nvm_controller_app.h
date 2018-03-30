/**
 * @file nvm_controller_app.h
 * Saves and restores non-volatile data of apps.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NVM_CONTROLLER_APP_H_
#define NVM_CONTROLLER_APP_H_

#define NVM_CONTROLLER_MAX_NUM_ACCESSORS 13

#include "nvm_controller_api.h"
#include "gpos/utils/buffer/buffer.h"
#include "gpos/hardware/microcontrollers/base.h"
#include "assert.h"

/**
 * Used to indicate whether duplicacy is enabled or disabled in the NvmControllerApp
 */
typedef enum{
	ENABLE_DUPLICACY,
	DISABLE_DUPLICACY
}nvm_duplicacy_t;

APP(NvmControllerApp, NvmController_API)
private:

	/**
	 * The maximum size in information flash which can be used for
	 * storing non volatile parameters. If duplicacy is enabled, this variable
	 * is 256 bytes; if duplicacy is disabled, this variable is 512 bytes
	 */
	uint32_t NVM_SIZE;

	/**
	 *  The virtual address marking the beginning of the information flash segment D.
	 */
	const void *NVM_SECTION_1_ADDR;

	/**
	 *  The virtual address marking the beginning of the information flash segment C
	 */
	const void *NVM_SECTION_1_5_ADDR;

	/**
	 *  The virtual address marking the beginning of the information flash segment B
	 */
	const void *NVM_SECTION_2_ADDR;

	/**
	 *  The virtual address marking the beginning of the information flash segment A
	 */
	const void *NVM_SECTION_2_5_ADDR;

	/**
	 * Represents the number of bytes used to represent the CRC of each registered nvm_struct
	 */
	const uint16_t NUM_CRC_BYTES;

	/**
	 * Helper variable used to keep track of the cumulative number of bytes occupied by all
	 * accessors registered thus far
	 */
	uint32_t _nextFreeOffset;

	/**
	 * Stores a list of all registered NVM_Accessors
	 */
	StaticBuffer<NVM_Accessor *, NVM_CONTROLLER_MAX_NUM_ACCESSORS> _accessors;

	/**
	 * A flag which indicates whether duplicacy is enabled or not
	 */
	nvm_duplicacy_t _duplicacy;

	

	/**
	 * This function tries to populate the
	 * nvm_struct with the values given from above assigned memory chunk in information flash.
	 * If duplicacy is enabled, and if one of the two sections in info flash are corrupted, then this
	 * function recovers from the alternate section and fixes the corrupted section.
	 *
	 * @param accessor is the NVM_Accessor which is to be initialized with the contents from info flash
	 * @return true if the nvm_struct represented by accessor was populated correctly (this can happen
	 * 		   only if computed CRC matches the calculated CRC of atleast one section in the inforation flash.
	 * 		   false if information flash is irrecoverably corrupted
	 */
	bool _initializeRamFromNVM(NVM_Accessor *accessor);

public:
      /**
	 * This function is called in the update loop if any of the registered accessors have been marked dirty.
	 * This function simply flushes the contents of all nvm_structs into the info flash section.
	 */
	void _refreshNVM();

	/**
	 * @param duplicacy_ is a flag which indicates whether duplicacy should be enabled or not
	 */
	NvmControllerApp(Environment* env_, nvm_duplicacy_t duplicacy_);

	/**
	 * Registers a given NVM_Accessor, and depending upon the _nextFreeOffset variable,
	 * (and also the sizeof the nvm_struct which is registered with the accessor) assigns a memory chunk
	 * in the information flash to the argument accessor.
	 *
	 * @param accessor is the NVM_Accessor which is to be registered with the NvmControllerApp
	 * @return false if either there is not sufficient memory available in the info flash to accomodate
	 * 		   for more accessors, or if the info flash is corrupted which implies that the contents of
	 * 		   the nvm_struct represented by accessor were not initialized
	 */
	bool registerAccessor(NVM_Accessor *accessor);

	/**
	 * Clears all NVM sections. ie, initializes the entire information flash bank (512 bytes) with 0xFF
	 */
	void clear();
ENDAPP


#endif  /** NVM_CONTROLLER_APP_H_ */
