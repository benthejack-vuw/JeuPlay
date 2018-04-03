#include "fastPin.h"

uint8_t BufferMask[8] =
{
  B00000001,
  B00000010,
  B00000100,
  B00001000,
  B00010000,
  B00100000,
  B01000000,
  B10000000  // maybe signed bit .. unsigned int type preferable….
};
  
FastPin::FastPin(uint8_t pin){
  set_pin(pin);
}

void FastPin::set_pin(uint8_t pin){
  _pin = pin;
  _shift = _pin <= 13 ? _pin % 8 : _pin-14;
  set_registers(_pin);
}

FastPin::set_registers(uint8_t pin){
  if(pin <= 7){
    _mode_register = &DDRD;
    _read_register = &PIND;
    _write_register = &PORTD;
  }else if(pin <= 13){
    _mode_register = &DDRB;
    _read_register = &PINB;
    _write_register = &PORTB;
  }else if(pin <= 21){
    _mode_register = &DDRC;
    _read_register = &PINC;
    _write_register = &PORTC;
  }
}

uint8_t FastPin::pin_mask(){
  return BufferMask[_shift];
}

void FastPin::mode(const uint8_t &mode, bool skip_set = false){
    if(_mode != mode){
      _mode = mode;  
      if(!skip_set && mode == FP_INPUT){
        *_mode_register = *_mode_register & (~(pin_mask()));
      }else if(!skip_set && mode == FP_OUTPUT){
        *_mode_register = *_mode_register | pin_mask();
      }
    }
}

bool FastPin::read(){
  return (bool)((*_read_register & pin_mask()) >> _shift);
}

void FastPin::write(bool value){
  *_write_register = value ? *_mode_register & (~(pin_mask())) : *_mode_register | pin_mask();
}

