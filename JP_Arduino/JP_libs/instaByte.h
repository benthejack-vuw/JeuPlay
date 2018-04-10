#include <Arduino.h>
#include "fastPin.h"

class InstaByte{
public:
  InstaByte(uint8_t * pins);
  void set_control_pins(uint8_t * pins, uint8_t num);
  void mode(const uint8_t & mode);
  uint8_t read(uint8_t byte_number = 0);
  void write(uint8_t num, uint8_t byte_number = 0);
  void pull_values();
  void print_binary();
private:
  FastPin _fast_pins[8];
  FastPin _control_pins[8];
  uint8_t _num_control_pins;
  uint8_t _values[8];
};
