#include "jpJoystick.h"
#include "jpDistanceMeter.h"
#include "instaByte.h"

float count = 0;

JpDistanceMeter * meter;
JpJoystick js(2,3,4,5);

uint8_t pins[8] = {4,5,6,7,8,9,10,11};
uint8_t control_pins[1] = {14};
InstaByte insta(pins);

void setup() {
  Serial.begin(115200);

  pinMode(8,OUTPUT);
  
  meter = JpDistanceMeter::new_distance_meter(15, 165.0, 7, 6);
  
  insta.mode(FP_OUTPUT);
  insta.set_control_pins(control_pins, 1);
}

void loop() {
  insta.write(meter->distance());
  count = count+0.01;
  delay(10);
}


