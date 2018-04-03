#include <Arduino.h>
#include "fastPin.h"

class InstaByte{
public:
  InstaByte(uint8_t * pins);
  void set_control_pins(uint8_t * pins, uint8_t num);
  void mode(const uint8_t & mode);
  int read(int byte_number = 0);
  void write(uint8_t num, int byte_number = 0);
  int pull_values();
private:
  FastPin _fast_pins[8];
  FastPin _control_pins[8];
  uint8_t _num_control_pins;
  uint8_t _values[8];
};
