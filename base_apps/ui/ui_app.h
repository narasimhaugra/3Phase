/**
 * @file ui_app.h
 * A generic ui API
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#ifndef UI_APP_H_
#define UI_APP_H_

#include "ui_api.h"



APP(UiApp, Ui_API)

protected:
const uint16_t REFRESH_PERIOD_MS;  /** Time between state refreshes */

ui_state_t UI_STATE_IDLE;
static const ui_state_t UI_STATE_STARTUP = 0;
uint16_t _numberOfStates;
ui_state_t currentState;  /** Current UI state */
ui_state_t previousState;  /** Previous UI state */
StopWatch refreshTimer;  /** Timer for refreshing states */
//StopWatch cycleTimer;  /** Timer for switching states during auto-cycle */

public:
/**
 * Determine whether one state is higher priority than another.
 *
 * @param state1 First state to compare.
 * @param state2 Second state to compare.
 * @return true if state1 is higher priority than state2, false otherwise.
 */
bool higherPriority(ui_state_t state1, ui_state_t state2);

/**
 * Get the highest priority state whose entrance condition is true.
 *
 * @return highest-priority state whose entrance condition is true.
 */
ui_state_t getHighestPriorityStateThatCanEnter();


void setNumberOfStates(uint16_t numberOfStates_);
/**
 * Perform whatever action is necessary to handle the given state.
 *
 * @param newState State to enter.
 */
virtual void stateEnterHandler(ui_state_t state) = 0;

/**
 * Determine whether the given state's entrance condition is true.
 *
 * @param state State whose entrance condition we want to check.
 * @return true if entrance condition is true, false otherwise.
 */
virtual bool stateEntranceConditionTrue(ui_state_t state) = 0;

/**
 * Determine whether the given state's exit condition is true.
 *
 * @param state State whose exit condition we want to check.
 * @return true if exit condition is true, false otherwise.
 */
virtual bool stateExitConditionTrue(ui_state_t state) = 0;

/**
 * Performs an update of the contents of the given state based on
 * the latest information.
 *
 * @param state State to refresh.
 */
virtual void stateRefreshHandler(ui_state_t state) = 0;


/**
 * Update the various individual UI elements, such as power indicator LED.
 */
virtual void globalRefreshHandler() = 0;


ENDAPP


#endif  /** UI_APP_H_ */
