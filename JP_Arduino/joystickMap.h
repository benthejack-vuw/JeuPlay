#ifndef JOYSTICKMAP_H
#define JOYSTICKMAP_H

class JoystickMap{
  public:
      JoystickMap(int top_pin, int right_pin, int bottom_pin, int left_pin);
      bool value_at(int pin);
      bool any_others(int pin);
      void debug_pins();
            
  private:
    int _top_pin, _right_pin, _bottom_pin, _left_pin;
    bool _top_value, _right_value, _bottom_value, _left_value;
};

#endif
