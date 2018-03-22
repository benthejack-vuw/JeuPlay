#include <arduino.h>
#include "./jpDistanceMeter.h"

//global variables and function for use with timer interrupt (can't use static members)
JpDistanceMeter * _measurers[MAX_MEASURERS];
bool timer_is_setup = false;
int _num_measurers;
int tcnt2;

void update_meters(){
  for(int i = 0; i < _num_measurers; ++i){
    _measurers[i]->tick();
  }
}

JpDistanceMeter::JpDistanceMeter(int ticks_per_revolution, float distance_per_revolution, int pin_1, int pin_2):
  _tpr(ticks_per_revolution), _dpr(distance_per_revolution), _ticks(0)
{
  //set up buffers for using instead of digitalRead this is 50x faster than using digitalRead()
  //http://www.instructables.com/id/Fast-digitalRead-digitalWrite-for-Arduino/
  _pin1 = pin_1;
  _pin2 = pin_2;
  _pin1_shift = pin_1 < 8 ? pin_1 : pin_1-8;
  _pin2_shift = pin_2 < 8 ? pin_2 : pin_2-8;
  _pin1_mask = 1 << _pin1_shift;
  _pin2_mask = 1 << _pin2_shift;
  _pin1_buffer = pin_1 < 8 ? &PIND : &PINB;
  _pin2_buffer = pin_2 < 8 ? &PIND : &PINB;

  pinMode(pin_1, INPUT);
  pinMode(pin_2, INPUT);
  digitalWrite(pin_1, HIGH);//activate internal pullup resistor
  digitalWrite(pin_2, HIGH);//activate internal pullup resistor

  _debouncer.attach(_pin1);
  _debouncer.interval(1);

  setup_timer(); 
}

void JpDistanceMeter::tick() {
  // the following line is thae same as: _ticks += digitalRead(_pin1) == digitalRead(_pin2) ? 1 : -1;
  _debouncer.update();
  if(_debouncer.risingEdge()){
    _ticks += (bool)(*_pin2_buffer & _pin2_mask) ? 1 : -1;
    _last_update  = millis();
  }else{
    if(millis() - _last_update > _timeout){
      _ticks /= 2;
      _last_update  = millis();
    }
  }
}

float JpDistanceMeter::distance() {
  return (_ticks / (_tpr + 0.0)) * _dpr;
}

JpDistanceMeter * JpDistanceMeter::new_distance_meter(int ticks_per_revolution, float distance_per_revolution, int pin1, int pin2) {
  if (_num_measurers < MAX_MEASURERS) {
    JpDistanceMeter * measurer = new JpDistanceMeter(ticks_per_revolution, distance_per_revolution, pin1, pin2);
    _measurers[_num_measurers] = measurer;
    _num_measurers++;
    return measurer;
  } else {
    return 0;
  }
}

void  JpDistanceMeter::setup_timer() {

  if (!timer_is_setup) {
    timer_is_setup = true;
    /* First disable the timer overflow interrupt while we're configuring */
    TIMSK2 &= ~(1 << TOIE2);

    /* Configure timer2 in normal mode (pure counting, no PWM etc.) */
    TCCR2A &= ~((1 << WGM21) | (1 << WGM20));
    TCCR2B &= ~(1 << WGM22);

    /* Select clock source: internal I/O clock */
    ASSR &= ~(1 << AS2);

    /* Disable Compare Match A interrupt enable (only want overflow) */
    TIMSK2 &= ~(1 << OCIE2A);

    /* Now configure the prescaler to CPU clock divided by 128 */
    TCCR2B |= (1 << CS22)  | (1 << CS20); // Set bits
    TCCR2B &= ~(1 << CS21);           // Clear bit

    /* We need to calculate a proper value to load the timer counter.
       The following loads the value 131 into the Timer 2 counter register
       The math behind this is:
       (CPU frequency) / (prescaler value) = 125000 Hz = 8us.
       (desired period) / 8us = 125.
       MAX(uint8) + 1 - 125 = 131;
    */
    /* Save value globally for later reload in ISR */
    tcnt2 = 131;

    /* Finally load end enable the timer */
    TCNT2 = tcnt2;
    TIMSK2 |= (1 << TOIE2);

  }
}

ISR(TIMER2_OVF_vect) {
  /* Reload the timer */
  TCNT2 = tcnt2;
  update_meters();

}
