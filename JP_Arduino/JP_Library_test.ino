#include "./jpJoystick.h"
#include "./jpDistanceMeter.h"

JpJoystick joystick(9, 7, 11, 5);
JpDistanceMeter * meter;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  joystick.powerPins(6, 8, 10, 12);
  meter = JpDistanceMeter::new_distance_meter(15, 165.0, 3, 2);

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print("joystick:");
  Serial.print(joystick.stick_direction().as_string());
  
  Serial.print("  measurer(mm):");
  Serial.println(meter->distance());
  

  delay(500);
}


