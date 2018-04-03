#include "instaByte.h"

#include <MozziGuts.h>
#include <Oscil.h> // oscillator template
#include <tables/sin2048_int8.h> // sine table for oscillator

// use: Oscil <table_size, update_rate> oscilName (wavetable), look in .h file of table #included above
Oscil <SIN2048_NUM_CELLS, AUDIO_RATE> aSin0(SIN2048_DATA);
Oscil <SIN2048_NUM_CELLS, AUDIO_RATE> aSin1(SIN2048_DATA);
Oscil <SIN2048_NUM_CELLS, AUDIO_RATE> aSin2(SIN2048_DATA);

// use #define for CONTROL_RATE, not a constant
#define CONTROL_RATE 64 // powers of 2 please

uint8_t pins[8] = {2,3,4,5,6,7,8,10};
InstaByte insta(pins);
  
int freq = 440;
byte buff[1];

void setup() {
  // put your setup code here, to run once:
  
  startMozzi(CONTROL_RATE); // set a control rate of 64 (powers of 2 please)
  aSin0.setFreq(440); // set the frequency
  aSin1.setFreq(220); // set the frequency
  aSin2.setFreq(110); // set the frequency
}


void updateControl() {
  //arduno non blocking Setial
 
  freq = insta.read();
  aSin0.setFreq((freq*2+100)*4);
  aSin1.setFreq((freq*2+200)*2);
  aSin2.setFreq((freq*2+200));
}


int updateAudio() {
  return aSin0.next()*aSin1.next()*aSin2.next(); // return an int signal centred around 0
}


void loop() {
  audioHook(); // required here
}

