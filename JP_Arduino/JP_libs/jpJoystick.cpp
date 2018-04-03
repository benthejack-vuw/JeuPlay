#include <arduino.h>
#include "./jpJoystick.h"
#include "./joystickMap.h"

JpJoystick::JpJoystick(int top_pin, int right_pin, int bottom_pin, int left_pin):
_top_pin(top_pin), _right_pin(right_pin), _bottom_pin(bottom_pin), _left_pin(left_pin)
{
  pinMode(top_pin, INPUT);
  pinMode(right_pin, INPUT);
  pinMode(bottom_pin, INPUT);
  pinMode(left_pin, INPUT);
  _directions[0] = new StickDirection(UP_RIGHT, top_pin, right_pin);
  _directions[1] = new StickDirection(UP, top_pin);
  _directions[2] = new StickDirection(UP_LEFT, top_pin, left_pin);
  _directions[3] = new StickDirection(LEFT, left_pin);
  _directions[4] = new StickDirection(DOWN_LEFT, bottom_pin, left_pin);
  _directions[5] = new StickDirection(DOWN, bottom_pin);
  _directions[6] = new StickDirection(DOWN_RIGHT, bottom_pin, right_pin);
  _directions[7] = new StickDirection(RIGHT, right_pin);
  _directions[8] = new StickDirection(MIDDLE);
}

void JpJoystick::debug_buttons(){
  JoystickMap buttons = JoystickMap(_top_pin, _right_pin, _bottom_pin, _left_pin);
  buttons.debug_pins();
}

StickDirection JpJoystick::stick_direction(){
  
  JoystickMap buttons = JoystickMap(_top_pin, _right_pin, _bottom_pin, _left_pin);
  
  //maybe do as callback with const argument so they cant change the direction?
  for(int i = 0; i < 9; ++i){
    if(_directions[i]->is_triggered(buttons))
      return *_directions[i];
  }
  
  return *_directions[8];
}
