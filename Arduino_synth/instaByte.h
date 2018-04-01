#include <Arduino.h>

class InstaByte{
public:
  InstaByte(uint8_t * p1);
  void set_to_read();
  void set_to_write();
  int read();
  void write(uint8_t num);

private:
  uint8_t * _pins;
  uint8_t * _offsets;
  uint8_t _pin_mask;
  uint8_t _pin_shifts[8];
  uint8_t * _read_buffers[8];
  uint8_t * _write_buffers[8];
};
