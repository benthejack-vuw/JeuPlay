#include <jpDistanceMeter.h>
#include <instaByte.h>

JpDistanceMeter *m1, *m2;
uint8_t pins[8] = {4,5,6,7,8,9,10,11};
uint8_t control_pins[1] = {14};
InstaByte i(pins);

void setup() {
  i.set_control_pins(control_pins, 1);
  m1 = JpDistanceMeter::new_distance_meter(15, 165.0, 2, 3);
  m2 = JpDistanceMeter::new_distance_meter(15, 165.0, 12, 13);
}

void loop() {
  uint8_t v1 = ((uint8_t)(m1->distance()/11.0));
  uint8_t v2 = ((uint8_t)(m2->distance()/11.0));
  
  i.write(v1, 0);
  delay(30);
  i.write(v2, 1);
  delay(30);  
}


