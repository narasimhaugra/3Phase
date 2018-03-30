/**
 * @file blink_green_led_app.h
 * Blinks the greenLed LED at a fixed rate.
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef BLINK_GREEN_LED_APP_H_
#define BLINK_GREEN_LED_APP_H_

#include <stdint.h>
#include "blink_green_led_api.h"
#include "gpos/utils/time/stop_watch.h"


APP(BlinkGreenLedApp, BlinkGreenLed_API)
private:
	const uint16_t BLINK_PERIOD_MS;  /** Duration of a single blink state (on or off) */
	StopWatch timer;  /** Timer to keep track of blinking */
ENDAPP


#endif  /** BLINK_GREEN_LED_APP_H_ */
