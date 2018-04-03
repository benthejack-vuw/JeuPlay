#include "jpJoystick.h"
#include "jpDistanceMeter.h"
//#include "instaByte.h"

float count = 0;

JpDistanceMeter * meter;
JpJoystick js(2,3,4,5);

//uint8_t pins[8] = {4,5,6,7,8,9,10,11};
//InstaByte insta(pins);

void setup() {
  Serial.begin(115200);

  pinMode(8,OUTPUT);
  
  meter = JpDistanceMeter::new_distance_meter(15, 165.0, 7, 6);
  
  //insta.mode(FP_OUTPUT);
}

void loop() {
  //insta.write(constrain((meter->distance()/11.0), 0, 1000));
  Serial.print(js.stick_direction().as_string());
  Serial.print("  :  ");
  Serial.println((int)meter->distance());
}


