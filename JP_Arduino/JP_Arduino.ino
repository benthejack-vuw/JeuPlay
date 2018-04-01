//#include <OWL.h>
#include "jpJoystick.h"
#include "jpDistanceMeter.h"
#include "instaByte.h"

//OWL owl;
float count = 0;

//JpJoystick joystick(9, 7, 11, 5);
JpDistanceMeter * meter;
uint8_t pins[8] = {4,5,6,7,8,9,10,11};
InstaByte i(pins);

void setup() {
  //owl.statusPin(13);
  //owl.connect(9600);
  //joystick.powerPins(6, 8, 10, 12);
  meter = JpDistanceMeter::new_distance_meter(15, 165.0, 3, 2);

}

void loop() {

//  OWLCommand c = owl.pollSerial();
//  if(c.command.indexOf("jp_data") >= 0){
//      String args[2];
//      args[0] = joystick.stick_direction().as_string();
//      args[1] = String(meter->distance());
//      owl.sendCommand("jp_data", 2, args);
//  }else if(c.command.indexOf("reset") >= 0){
//      digitalWrite(13,HIGH);
//      owl.reset();
//  }

//  delay(10);
}


