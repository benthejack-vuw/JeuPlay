#include <OWL.h>
#include <jpJoystick.h>

OWL owl;
JpJoystick j1(2, 3, 4, 5);

void setup() {
  owl.statusPin(13);
  owl.connect(9600);
}

void loop() {

  OWLCommand c = owl.pollSerial();
  if(c.command.indexOf("jp_data") >= 0){
      String args[1];
      args[0] = j1.stick_direction().as_string();
      owl.sendCommand("jp_data", 1, args);
  }else if(c.command.indexOf("reset") >= 0){
      digitalWrite(13,HIGH);
      owl.reset();
  }

  delay(10);
}


