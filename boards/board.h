#ifndef BOARD_H
#define BOARD_H

#include "gpos/utils/utils.h"
#include "gpos/hardware/microcontrollers/base/timer.h"

class Board : public base::TimerUser
{
public:


	void init();
	static MyTime systemTime;
	virtual void update()=0;
	virtual void reset()=0;
};

#endif
