/* Plotter

Description: Reads the accelerometer values of the X, Y and Z axes and
transmits them over the Serial port. To be using in conjunction with
the Plotter_Processing.pde program.

Author: Owen Brasier
Date: July 2015

http://challenge.madmaker.com.au
*/

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
