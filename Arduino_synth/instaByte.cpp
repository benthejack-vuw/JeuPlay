#include "instaByte.h"

InstaByte::InstaByte(uint8_t pins[8])
{
  
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].set_pin(pins[i]);
  }
}

void InstaByte::mode(const uint8_t &mode){
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].mode(mode);
  }
}

int InstaByte::read(){
  int num  = 0;
  for(int i = 0; i < 8; ++i){
    num |= (_fast_pins[i].read() << i);
  }
  return num;
}

void InstaByte::write(uint8_t num){
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].write(_fast_pins[i].pin_mask() & num);
  }
}
