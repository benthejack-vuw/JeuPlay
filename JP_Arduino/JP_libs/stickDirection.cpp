#include "./stickDirection.h"

StickDirection::StickDirection(Direction dir, int pin1=-1, int pin2=-1):
_pin1(pin1), _pin2(pin2), _direction(dir) {}

bool StickDirection::is_triggered(JoystickMap jsMap){
  bool p1 = (_pin1 == -1 && !jsMap.any_others(_pin2)) || jsMap.value_at(_pin1);
  bool p2 = (_pin2 == -1 && !jsMap.any_others(_pin1)) || jsMap.value_at(_pin2);

  return p1 && p2;
}

Direction StickDirection::direction(){
  return _direction;
}

String StickDirection::as_string(){
  switch(_direction){
    case 0:
      return "MIDDLE";
      break;
    case 1:
      return "UP_RIGHT";
      break;
    case 2:
      return "UP";
      break;
    case 3:
      return "UP_LEFT";
      break;
    case 4:
      return "LEFT";
      break;
    case 5:
      return "DOWN_LEFT";
      break;
    case 6:
      return "DOWN";
      break;
    case 7:
      return "DOWN_RIGHT";
      break;
    case 8:
       return "RIGHT";
       break;
    default:
       return "NONE";
       break;
  }
}

  

