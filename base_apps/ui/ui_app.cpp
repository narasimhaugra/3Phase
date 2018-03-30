/**
 * @file ui_app.cpp
 * A generic ui API
 *
 * @section LICENSE
 * [Standard license info.]
 *
 * Copyright 2014 Gram Power, Inc.
 */

#include "ui_app.h"
/**
 *This needs to go here to resolve circular dependency issues; try to make it
 * neater?
 */
#include "environment.h"


CONSTRUCT(UiApp)
	, refreshTimer(&(env->board.systemTime))
	, currentState(UI_STATE_STARTUP)
	, previousState(UI_STATE_STARTUP)
	, REFRESH_PERIOD_MS(500)
{
}


UPDATE(UiApp)
{
	if (stateExitConditionTrue(currentState))
	{
		previousState = currentState;
		currentState = getHighestPriorityStateThatCanEnter();
		stateEnterHandler(currentState);
	}
	ui_state_t stateChoice = getHighestPriorityStateThatCanEnter();
	if (higherPriority(stateChoice, currentState))
	{
		previousState = currentState;
		currentState = stateChoice;
		stateEnterHandler(stateChoice);
	}
	if(refreshTimer.getElapsedMilliSec() >= REFRESH_PERIOD_MS)
	{
		refreshTimer.reset();
		stateRefreshHandler(currentState);
	}
	globalRefreshHandler();
}

ui_state_t UiApp::getHighestPriorityStateThatCanEnter()
{
	uint16_t i;
	/**
	 * Cycle through all states from highest priority to lowest, returning the
	 * first state whose entrance condition is true.
	 */
	for (i = _numberOfStates; i >= 1; i--) {
		if (stateEntranceConditionTrue((ui_state_t)i)) {
			return (ui_state_t)i;
		}
	}
	return UI_STATE_IDLE;
}



bool UiApp::higherPriority(ui_state_t state1, ui_state_t state2)
{
	return state1 > state2;
}

void UiApp::setNumberOfStates(uint16_t numberOfStates_)
{
	_numberOfStates = numberOfStates_;
	UI_STATE_IDLE = numberOfStates_ + 1;
}
