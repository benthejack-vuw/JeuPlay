#ifndef FAST_PIN_H
#define FAST_PIN_H

#include <Arduino.h>

#define FP_INPUT  0
#define FP_OUTPUT 1

class FastPin{
public:
  FastPin(){};
  FastPin(uint8_t pin);
  void set_pin(uint8_t pin);
  set_registers(uint8_t pin);
  uint8_t pin_mask();
  void mode(const uint8_t &mode, bool skip_set = false);
  bool read();
  void write(bool value);

private:
  uint8_t _pin;
  uint8_t _shift;
  uint8_t *_mode_register, *_read_register, *_write_register;
  uint8_t _mode;
};

#endif

