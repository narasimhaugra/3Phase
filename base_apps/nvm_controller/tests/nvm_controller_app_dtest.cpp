/**
 * @file nvm_controller_dtest.cpp
 * Desktop unit tests for the nvm_controller app.
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
#include "../nvm_controller_app.h"
#include "../mocks/environment.h"
#include "nvm_accessor.h"

using ::testing::Return;


/** Test fixture */
class NvmControllerAppTest : public ::testing::Test
{
protected:
    Environment env;

    NvmControllerAppTest()
    {
    }
};


/** Register single small accessor and ensure allocation */
TEST_F(NvmControllerAppTest, RegisterSingleSmallAccessor)
{
	typedef struct nvm_data_struct
	{
		uint32_t element;
	} nvm_data_t;

    EXPECT_CALL(env.board.infoFlash, getCRC(0, sizeof(nvm_data_t)))
        .Times(1)
        .WillOnce(Return(0));

	nvm_data_t nvm_data;
	NVM_Accessor accessor(&nvm_data, sizeof(nvm_data));
	
    ASSERT_TRUE(env.nvmController.registerAccessor(&accessor));
	ASSERT_TRUE(accessor.registered());
}


/**
 * Register single accessor that takes entire memory and ensure no more
 * can be registered
 */
TEST_F(NvmControllerAppTest, RegisterSingleLargeAccessor)
{
    uint8_t nvmData[254];
    
    EXPECT_CALL(env.board.infoFlash, getCRC(0, sizeof(nvmData)))
        .WillRepeatedly(Return(0));

    /** Expect reading of the CRC */
    EXPECT_CALL(env.board.infoFlash, read((void *) sizeof(nvmData), testing::_, 2));
    EXPECT_CALL(env.board.infoFlash, read(0, testing::_, sizeof(nvmData)));

	NVM_Accessor accessor(&nvmData, sizeof(nvmData));
	
    ASSERT_TRUE(env.nvmController.registerAccessor(&accessor));
	ASSERT_TRUE(accessor.registered());

    uint8_t secondNvmData;

	NVM_Accessor secondAccessor(&secondNvmData, sizeof(secondNvmData));

	ASSERT_TRUE(! env.nvmController.registerAccessor(&secondAccessor));
	ASSERT_TRUE(! secondAccessor.registered());
}

/**
 * Register two accessors that take entire memory and ensure no more
 * can be registered
 */
TEST_F(NvmControllerAppTest, RegisterTwoAccessorsWhichTakeWholeMemory)
{
	uint8_t nvmData1[126];
    uint8_t nvmData2[126];

	NVM_Accessor accessor1(&nvmData1, sizeof(nvmData1));
	NVM_Accessor accessor2(&nvmData2, sizeof(nvmData2));

    ASSERT_TRUE(env.nvmController.registerAccessor(&accessor1));
	ASSERT_TRUE(accessor1.registered());
    ASSERT_TRUE(env.nvmController.registerAccessor(&accessor2));
    ASSERT_TRUE(accessor2.registered());

    uint8_t extraNvmData;

	NVM_Accessor extraAccessor(&extraNvmData, sizeof(extraNvmData));

    ASSERT_TRUE(! env.nvmController.registerAccessor(&extraAccessor));
	ASSERT_TRUE(! extraAccessor.registered());
}

/**
 * Register maximum number of accessors
 */
TEST_F(NvmControllerAppTest, RegisterMaxNumAccessors)
{
	uint8_t nvmData[NVM_CONTROLLER_MAX_NUM_ACCESSORS];
    NVM_Accessor *accessors[NVM_CONTROLLER_MAX_NUM_ACCESSORS];

    for (uint16_t i = 0; i < NVM_CONTROLLER_MAX_NUM_ACCESSORS; i++)
    {
        accessors[i] = new NVM_Accessor(&(nvmData[i]), 1);
        ASSERT_TRUE(! accessors[i]->registered());
        ASSERT_TRUE(env.nvmController.registerAccessor(accessors[i]));
        ASSERT_TRUE(accessors[i]->registered());
    }

    /** Ensure that a single extra accessor can't be registered */
    uint8_t secondNvmData;
    NVM_Accessor secondAccessor(&secondNvmData, 1);
    
    ASSERT_TRUE(! env.nvmController.registerAccessor(&secondAccessor));
    ASSERT_TRUE(! secondAccessor.registered());
}

/**
 * Re-registering an accessor should fail
 */
TEST_F(NvmControllerAppTest, ReRegisterAccessor)
{
	typedef struct nvm_data_struct
	{
		uint32_t element;
	} nvm_data_t;

	nvm_data_t nvm_data;
	NVM_Accessor accessor(&nvm_data, sizeof(nvm_data));
	
    ASSERT_TRUE(env.nvmController.registerAccessor(&accessor));
	ASSERT_TRUE(accessor.registered());

    /**
     * Try to re-register the same accessor - should fail, but the accessor
     * should still be registered
     * */
    ASSERT_TRUE(! env.nvmController.registerAccessor(&accessor));
    ASSERT_TRUE(accessor.registered());
}

/**
 * Registering an accessor of length zero should fail
 */
TEST_F(NvmControllerAppTest, RegisterAccessorLengthZero)
{
    uint8_t nvmData;
    NVM_Accessor accessor(&nvmData, 0);
    
    ASSERT_TRUE(! env.nvmController.registerAccessor(&accessor));
    ASSERT_TRUE(! accessor.registered());
}

// TODO: What about accessors with zero length?
