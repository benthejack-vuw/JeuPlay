#include <Arduino.h>
#include "fastPin.h"

class InstaByte{
public:
  InstaByte(uint8_t * pins);
  void mode(const uint8_t & mode);
  int read();
  void write(uint8_t num);

private:
  FastPin _fast_pins[8];
};
