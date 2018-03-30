/**
 * @file blink_green_led_app.cpp
 * Blinks the greenLed LED at a fixed rate.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "blink_green_led_app.h"
/**
 *This needs to go here to resolve circular dependency issues; try to make it
 * neater?
 */
#include "environment.h"


CONSTRUCT(BlinkGreenLedApp)
, BLINK_PERIOD_MS(500)
, timer(&(env->board.systemTime))
{
}


void BlinkGreenLedApp::update()
{
	/** Toggle the green LED every BLINK_PERIOD_MS seconds */
	if (timer.getElapsedMilliSec() > BLINK_PERIOD_MS)
	{
		env->board.greenLed.toggle();
		timer.reset();
	}
}
