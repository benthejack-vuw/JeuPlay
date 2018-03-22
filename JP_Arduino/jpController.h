#include "jpJoystick.h"
#include "jpDistanceMeter.h"

class JpController{
  public:
    JpController();
   
  private:
    JpJoystick * _joystick;
    JpDistanceMeter * _distanceMeter;
};

