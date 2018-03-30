/**
 * @file nvm_controller_app.cpp
 * Saves and restores non-volatile data of apps.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "nvm_controller_app.h"
/**
 *This needs to go here to resolve circular dependency issues; try to make it
 * neater?
 */
#include "environment.h"

NvmControllerApp::NvmControllerApp(Environment *env_, nvm_duplicacy_t duplicacy_)
	: env(env_)
	, NVM_SECTION_1_ADDR((void *)0)
	, NVM_SECTION_1_5_ADDR((void *)128)
	, NVM_SECTION_2_ADDR((void *)256)
	, NVM_SECTION_2_5_ADDR((void *)384)
	, NUM_CRC_BYTES(2)
	, _nextFreeOffset(0)
	, _accessors()
	, _duplicacy(duplicacy_)
{
	if(_duplicacy == ENABLE_DUPLICACY)
	{
		NVM_SIZE = 256;
	}
	else
	{
		NVM_SIZE = 512;
	}
}

/**
 * Iterates through all registered NVM_Accessors and checks whether any of them is dirty.
 * If so, then the information flash is update with the corresponding values from RAM
 */
void NvmControllerApp::update()
{
    if (false == env->board.amIrestarting())
    {
        return;
    }
  
	/** * Iterate through all accessors and check if any are dirty */
	bool dirtyFound = false;
	NVM_Accessor *accessor;
	for (uint16_t i = 0; _accessors.read(&accessor, i); i++)
	{
		dirtyFound |= accessor->dirty();
		// TODO: Check if the dirty blocks are actually different (memcmp); otherwise
		// no need to rewrite the NVM
	}

	/** * If any were dirty, re-write the whole memory */
	if (dirtyFound)
	{
		_refreshNVM();
	}

	for (uint16_t i = 0; _accessors.read(&accessor, i); i++)
	{
		accessor->markClean();
	}
	//TODO: markClean only if dirtyFound
	// TODO: Put rate limiting on writes so that even if an app is marking dirty,
	// the program doesn't get stalled by constant writes
}


bool NvmControllerApp::registerAccessor(NVM_Accessor *accessor)
{
	/**
	 * * Check if accessor's associated nvm_struct has length greater than zero - if not, it just takes
	 * up room in the list without actually using memory, so we should decline
	 * to register it
	 */
	if (accessor->length() <= 0)
	{
		return false;
	}

	/** * Check if we can take another accessor */
	APP_ASSERT(_accessors.length() <= NVM_CONTROLLER_MAX_NUM_ACCESSORS)

	/**
	 * * Check if the accessor is already registered - if so we can't
	 * re-register
	 */
	 APP_ASSERT(!accessor->registered())


	 /**
	  * * Check if the memory managed by this accessor can fit in NVM
	  */
	 APP_ASSERT ((accessor->length() + NUM_CRC_BYTES) < (NVM_SIZE - _nextFreeOffset))


	 /** * Otherwise, register the accessor */
	 _accessors.push(accessor);
	 accessor->setNvmOffset(_nextFreeOffset);
	 _nextFreeOffset += accessor->length() + NUM_CRC_BYTES;
	 accessor->markRegistered();

	 /** * Finally, initialize RAM from flash */
	 // TODO: Do many more checks on integrity, handle errors, etc.
	 return _initializeRamFromNVM(accessor);
}


// TODO: Add redundancy
// TODO: Check each erase, write to make sure it succeeds; if not, throw an error
// (somewhere...)
void NvmControllerApp::_refreshNVM()
{
	// TODO: Encapsulate this logic into a lower layer or at least a separate
	// function
	env->board.infoFlash.eraseSegment((void *)NVM_SECTION_1_ADDR);
	env->board.infoFlash.eraseSegment((void *)(NVM_SECTION_1_5_ADDR));

	NVM_Accessor *accessor;
	for (uint16_t i = 0; _accessors.read(&accessor, i); i++)
	{
		env->board.infoFlash.write((void *)(accessor->nvmOffset()),
				(uint8_t *)accessor->ramAddress(), accessor->length());
		uint16_t crc = env->board.crcModule.getCheckValue((uint8_t *)accessor->ramAddress(),
				accessor->length());
		env->board.infoFlash.write((void *)(accessor->nvmOffset() + accessor->length()),
				(uint8_t *)&crc, 2);
	}

	if(_duplicacy == ENABLE_DUPLICACY)
	{
		env->board.infoFlash.eraseSegment((void *)NVM_SECTION_2_ADDR);
		env->board.infoFlash.eraseSegment((void *)(NVM_SECTION_2_5_ADDR));

		for (uint16_t i = 0; _accessors.read(&accessor, i); i++)
		{
			env->board.infoFlash.write((void *)(accessor->nvmBackupOffset()),
					(uint8_t *)accessor->ramAddress(), accessor->length());
			uint16_t crc = env->board.crcModule.getCheckValue((uint8_t *)accessor->ramAddress(),
					accessor->length());
			env->board.infoFlash.write((void *)(accessor->nvmBackupOffset() + accessor->length()),
					(uint8_t *)&crc, 2);
		}
	}
}

void NvmControllerApp::clear()
{
	env->board.infoFlash.eraseSegment((void *)NVM_SECTION_1_ADDR);
	env->board.infoFlash.eraseSegment((void *)(NVM_SECTION_1_5_ADDR));
	env->board.infoFlash.eraseSegment((void *)NVM_SECTION_2_ADDR);
	env->board.infoFlash.eraseSegment((void *)(NVM_SECTION_2_5_ADDR));
}


bool NvmControllerApp::_initializeRamFromNVM(NVM_Accessor *accessor)
{
	APP_ASSERT(accessor->registered());

	if(_duplicacy == ENABLE_DUPLICACY)
	{
		bool section1_corrupted = false;
		bool section2_corrupted = false;

		uint16_t section1_calculatedCRC = env->board.infoFlash.getCRC((void *)(accessor->nvmOffset()), accessor->length());
		uint16_t section1_recordedCRC = 0;
		env->board.infoFlash.read((void *)(accessor->nvmOffset() + accessor->length()), (uint8_t *)(&section1_recordedCRC), NUM_CRC_BYTES);
		section1_corrupted = section1_calculatedCRC != section1_recordedCRC;

		uint16_t section2_calculatedCRC = env->board.infoFlash.getCRC((void *)(accessor->nvmBackupOffset()), accessor->length());
		uint16_t section2_recordedCRC = 0;
		env->board.infoFlash.read((void *)(accessor->nvmBackupOffset() + accessor->length()), (uint8_t *)(&section2_recordedCRC), NUM_CRC_BYTES);
		section2_corrupted = section2_calculatedCRC != section2_recordedCRC;

		if(section1_corrupted && section2_corrupted)
		{
			return false;
		}

		if(section1_corrupted && !section2_corrupted)
		{
			env->board.infoFlash.eraseSegment((void*)(NVM_SECTION_1_ADDR));
			env->board.infoFlash.eraseSegment((void*)(NVM_SECTION_1_5_ADDR));
			uint8_t temp[128];
			env->board.infoFlash.read((void *)(NVM_SECTION_2_ADDR),
					temp, 128);
			env->board.infoFlash.write((void *)(NVM_SECTION_1_ADDR),
					temp, 128);
			env->board.infoFlash.read((void *)(NVM_SECTION_2_5_ADDR),
					temp, 128);
			env->board.infoFlash.write((void *)(NVM_SECTION_1_5_ADDR),
					temp, 128);
		}
	 	if(section2_corrupted && !section1_corrupted)
		{
			env->board.infoFlash.eraseSegment((void*)(NVM_SECTION_2_ADDR));
			env->board.infoFlash.eraseSegment((void*)(NVM_SECTION_2_5_ADDR));
			uint8_t temp[128];
			env->board.infoFlash.read((void *)(NVM_SECTION_1_ADDR),
					temp, 128);
			env->board.infoFlash.write((void *)(NVM_SECTION_2_ADDR),
					temp, 128);
			env->board.infoFlash.read((void *)(NVM_SECTION_1_5_ADDR),
					temp, 128);
			env->board.infoFlash.write((void *)(NVM_SECTION_2_5_ADDR),
					temp, 128);
		}
		// TODO: Check return value and throw error if it fails
		env->board.infoFlash.read((void *)(accessor->nvmOffset()),
				(uint8_t *)(accessor->ramAddress()), accessor->length());
		return true;
	}
	else
	{
		bool corrupted = false;
		uint16_t calculatedCRC = env->board.infoFlash.getCRC((void *)(accessor->nvmOffset()), accessor->length());
		uint16_t recordedCRC = 0;
		env->board.infoFlash.read((void *)(accessor->nvmOffset() + accessor->length()), (uint8_t *)(&recordedCRC), NUM_CRC_BYTES);
		corrupted = calculatedCRC != recordedCRC;

		if(!corrupted)
		{
			env->board.infoFlash.read((void *)(accessor->nvmOffset()),
					(uint8_t *)(accessor->ramAddress()), accessor->length());
			return true;
		}
	}
    return false;
}
