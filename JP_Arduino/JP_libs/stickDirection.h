#include <arduino.h>
#include "./joystickMap.h"

#ifndef STICKDIRECTION_H
#define STICKDIRECTION_H

enum Direction{
  MIDDLE,
  UP_RIGHT,
  UP,
  UP_LEFT,
  LEFT,
  DOWN_LEFT,
  DOWN,
  DOWN_RIGHT,
  RIGHT
};

class StickDirection{
  public:
    StickDirection(Direction dir, int pin1=-1, int pin2=-1);
    bool is_triggered(JoystickMap buttons);
    Direction direction();
    String as_string();
    
  private:
    Direction _direction;
    int _pin1, _pin2;
};

#endif /* STICKDIRECTION_H */
