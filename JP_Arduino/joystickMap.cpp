#include <arduino.h>
#include "./joystickMap.h"


JoystickMap::JoystickMap(int top_pin, int right_pin, int bottom_pin, int left_pin):
_top_pin(top_pin), _right_pin(right_pin), _bottom_pin(bottom_pin), _left_pin(left_pin)
{
 _top_value = digitalRead(_top_pin);
 _right_value = digitalRead(_right_pin);
 _bottom_value = digitalRead(_bottom_pin);
 _left_value = digitalRead(_left_pin); 
}

void JoystickMap::debug_pins(){
 Serial.print("top:");
 Serial.print(_top_value);
 Serial.print(" right:");
 Serial.print(_right_value);
 Serial.print(" bottom:");
 Serial.print(_bottom_value);
 Serial.print(" left:");
 Serial.println(_left_value);
}

bool JoystickMap::value_at(int pin){
  
    if(pin == _right_pin)
      return _right_value;
      
    if(pin == _top_pin)
      return _top_value; 
      
    if(pin ==_bottom_pin)
      return _bottom_value;
      
    if(pin ==_left_pin)
      return _left_value;
      
    return false;
}
      
bool JoystickMap::any_others(int pin){

    if(pin == -1)
      return _top_value || _right_value || _left_value || _bottom_value;
    
    if(pin == _right_pin)
      return _top_value || _left_value || _bottom_value;
      
    if(pin == _top_pin)
      return _right_value || _left_value || _bottom_value;
      
    if(pin == _bottom_pin)
      return _right_value || _top_value || _left_value;
      
    if(pin == _left_pin)
      return _right_value || _top_value || _bottom_value;
      
    return _top_value || _right_value || _left_value || _bottom_value;
 
}
