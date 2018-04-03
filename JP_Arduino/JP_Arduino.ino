#include "jpJoystick.h"
#include "jpDistanceMeter.h"
#include "instaByte.h"

float count = 0;

JpDistanceMeter * meter;
uint8_t pins[8] = {4,5,6,7,8,9,10,11};
InstaByte insta(pins);

void setup() {
  Serial.begin(115200);
  meter = JpDistanceMeter::new_distance_meter(15, 165.0, 3, 2);
  insta.set_to_write();
}

void loop() {
  insta.write(constrain((meter->distance()/11.0), 0, 1000));
  Serial.println((int)meter->distance());
}


