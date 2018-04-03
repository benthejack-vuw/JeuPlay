#include "instaByte.h"

InstaByte::InstaByte(uint8_t pins[8])
{ 
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].set_pin(pins[i]);
  }
}

void InstaByte::set_control_pins(uint8_t * pins, uint8_t num){
  _num_control_pins = num;
  for(int i = 0; i < _num_control_pins; ++i){
    _control_pins[i].set_pin(pins[i]);
  }
}

void InstaByte::mode(const uint8_t &mode){
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].mode(mode);
  }
}

int InstaByte::pull_values(){
//  int num  = 0;
//  for(int i = 0; i < 8; ++i){
//    num |= (_fast_pins[i].read() << i);
//  }
//
//  int byte_num = 0;
//  for(int i = 0; i < _num_control_pins; ++i){
//    byte_num |= (_control_pins[i].read() << i);
//  }
//  _values[byte_num] = num;
}

int InstaByte::read(int byte_number = 0){
  int num  = 0;
  for(int i = 0; i < 8; ++i){
    num |= (_fast_pins[i].read() << i);
  }
  return num;
}

void InstaByte::write(uint8_t num, int byte_number = 0){
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].write(_fast_pins[i].pin_mask() & num);
  }
}
