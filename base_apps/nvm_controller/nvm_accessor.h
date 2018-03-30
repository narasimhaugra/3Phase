/**
 * @file nvm_accessor.h
 * INSERT DESCRIPTION HERE.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef NVM_ACCESSOR_H_
#define NVM_ACCESSOR_H_

#include <stdint.h>


class NVM_Accessor
{
private:

public:
	// DEBUGGING
	void *_ramAddress;
	uint32_t _nvmOffset;
	uint32_t _len;
	bool _registered;
	bool _dirty;

	NVM_Accessor(void *ramAddress_, uint32_t len_)
		: _ramAddress(ramAddress_),
		  _nvmOffset(0),
		  _len(len_),
		  _registered(false),
		  _dirty(false)
	{
	}

	/** Functions for app to use */
	void markDirty()
	{
		_dirty = true;
	}

	/** Functions for controller to use */
	void markRegistered()
	{
		_registered = true;
	}

	uint32_t length()
	{
		return _len;
	}

	bool registered()
	{
		return _registered;
	}

	void markClean()
	{
		_dirty = false;
	}

	bool dirty()
	{
		return _dirty;
	}

	void setNvmOffset(uint32_t nvmOffset_)
	{
		_nvmOffset = nvmOffset_;
	}

	uint32_t nvmOffset()
	{
		return _nvmOffset;
	}

	uint32_t nvmBackupOffset()
	{
		return _nvmOffset + 256;
	}

	void *ramAddress()
	{
		return _ramAddress;
	}
};


#endif  /** NVM_ACCESSOR_H_ */
