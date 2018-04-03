#include "instaByte.h"



InstaByte::InstaByte(uint8_t pins[8])
{
  _pins = pins;
  _pin_mask = 0;
  for(int i = 0; i < 8; ++i){
    _read_buffers[i]  = _pins[i] < 8 ? &PIND : &PINB;
    _write_buffers[i] = _pins[i] < 8 ? &PORTD : &PORTB;
    _pin_shifts[i] = _pins[i]%8;
    _pin_mask |= !BufferMask[_pin_shifts[i]];
  }
}

void InstaByte::set_to_read(){
  for(int i = 0; i < 8; ++i){
    pinMode(_pins[i], INPUT);
  }
}

void InstaByte::set_to_write(){
  for(int i = 0; i < 8; ++i){
    pinMode(_pins[i], OUTPUT);
  }
}

int InstaByte::read(){
  int num  = 0;
  for(int i = 0; i < 8; ++i){
    num |= (((*_read_buffers[i] & BufferMask[_pin_shifts[i]]) >> _pin_shifts[i]) << i);//;
  }

  return num;
}

void InstaByte::write(uint8_t num){
  for(int i = 0; i < 8; ++i){
    digitalWrite(_pins[i], BufferMask[i] & num);
  }
}
