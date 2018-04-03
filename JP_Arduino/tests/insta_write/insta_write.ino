#include "instaByte.h"
int count = 0;
uint8_t pins[8] = {4,5,6,7,8,9,10,11};
InstaByte i(pins);

void setup() {
  // put your setup code here, to run once:
    Serial.begin(115200);

  i.mode(FP_OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int num = (int)(((sin(count)+1)/2.0)*255);
  //Serial.println(num);
  i.write(count);
  count += 1;
  delay(50);
}
