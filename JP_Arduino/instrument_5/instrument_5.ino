#include <OWL.h>
#include <jpJoystick.h>

OWL owl;
JpJoystick j1(2, 3, 4, 5);
JpJoystick j2(6, 7, 8, 9);
JpJoystick j3(10, 11, 12, 13);
JpJoystick j4(14, 15, 16, 17);

void setup() {
  owl.statusPin(13);
  owl.connect(9600);
}

void loop() {

  OWLCommand c = owl.pollSerial();
  if(c.command.indexOf("jp_data") >= 0){
      String args[4];
      args[0] = j1.stick_direction().as_string();
      args[1] = j2.stick_direction().as_string();
      args[3] = j3.stick_direction().as_string();
      args[4] = j4.stick_direction().as_string();
      owl.sendCommand("jp_data", 4, args);
  }else if(c.command.indexOf("reset") >= 0){
      digitalWrite(13,HIGH);
      owl.reset();
  }

  delay(10);
}


