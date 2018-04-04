#include <instaByte.h>

uint8_t pins[8] = {2,3,4,5,6,7,8,10};
uint8_t control_pins[1] = {14};

InstaByte i(pins);

void setup() {
  Serial.begin(115200);
  i.set_control_pins(control_pins, 1);
}

void loop() {
  // put your main code here, to run repeatedly:
  //i.print_binary();
  Serial.print(i.read(0));
  Serial.print("  :  ");
  Serial.println(i.read(1));
//i.read(0);
//i.read(1);

  delay(10);
}
