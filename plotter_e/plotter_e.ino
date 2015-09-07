#include <Esplora.h>
 
void setup() {
  Serial.begin(9600);
}
 
void loop() {
  int xAxis = Esplora.readAccelerometer(X_AXIS);
  int yAxis = Esplora.readAccelerometer(Y_AXIS);
  int zAxis = Esplora.readAccelerometer(Z_AXIS);
  Serial.print(xAxis);
  Serial.print(',');
  Serial.print(yAxis);
  Serial.print(',');
  Serial.println(zAxis);
  delay(5);
}
