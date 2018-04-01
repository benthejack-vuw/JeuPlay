#include "instaByte.h"

uint8_t pins[8] = {2,3,4,5,6,7,8,10};
InstaByte i(pins);

void setup() {
  Serial.begin(115200);
  i.set_to_read();
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(i.read());
  delay(10);
}
