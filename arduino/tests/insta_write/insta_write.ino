#include <instaByte.h>
int count = 0;
uint8_t pins[8] = {4,5,6,7,8,9,10,11};
uint8_t control_pins[1] = {14};
InstaByte i(pins);

void setup() {
  // put your setup code here, to run once:
    Serial.begin(115200);
  i.set_control_pins(control_pins, 1);
}

void loop() {
  // put your main code here, to run repeatedly:  int num = (int)(((sin(floater)+1)/2.0)*255);
  //Serial.println(num);
  i.write(count, 0);
  delay(100);
  
  i.write(255-count, 1);
  delay(100);
  
  count += 1;
}
