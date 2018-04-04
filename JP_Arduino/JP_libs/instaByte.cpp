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
    _fast_pins[i].mode(mode, true);
  }
  for(int i = 0; i < _num_control_pins; ++i){
    _control_pins[i].mode(mode, true);
  }
}

void InstaByte::pull_values(){
  int num  = 0;
  for(int i = 0; i < 8; ++i){
    num |= (_fast_pins[i].read() << i);
  }

  int byte_num = 0;
  for(int i = 0; i < _num_control_pins; ++i){
    byte_num |= (_control_pins[i].read() << i);
  }
  _values[byte_num] = num;
}

void InstaByte::print_binary(){
    for(int i = 0; i < 8; ++i){
      Serial.print(_fast_pins[i].read());
    }
    Serial.println();
}

uint8_t InstaByte::read(uint8_t byte_number = 0){
  pull_values();
  return _values[byte_number];
}

void InstaByte::write(uint8_t num, uint8_t byte_number = 0){

  for(int i = 0; i < _num_control_pins; ++i){
    _control_pins[i].write(false);
  }
  for(int i = 0; i < _num_control_pins; ++i){
    _control_pins[i].write(((1<<i) & byte_number) > 0);
  }

  for(int i = 0; i < 8; ++i){
    _fast_pins[i].write(false);
  }
  for(int i = 0; i < 8; ++i){
    _fast_pins[i].write(((1<<i) & num) > 0);
  }
}
