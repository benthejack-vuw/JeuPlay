#include "stickDirection.h"

#ifndef JPJOYSTICK_H
#define JPJOYSTICK_H

class JpJoystick{
  public:
    JpJoystick(int top_pin, int right_pin, int bottom_pin, int left_pin);
    void powerPins(int one, int two, int three, int four);
    void debug_buttons();
    StickDirection stick_direction();    
    
  private:
    StickDirection * _directions[9];
    int _top_pin;
    int _right_pin;
    int _bottom_pin;
    int _left_pin;
};


#endif
