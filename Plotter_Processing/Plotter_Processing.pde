  
/* This sketch takes data from the accelerometer on the arduino Esplora and plots it on a graph
 
 Author - Owen Brasier
 */
 
import processing.serial.*; // import the Serial library
 
String serial;
Serial port;
 
 
int numPoints = 1000;        // number of points on the graph
int stepSize = 10;          // time difference between steps in ms
int currentPoint = 0;
int prevTime = 0;
 
int box = 20;
int offset = 50;            // offset of x-axis, in pixels
int mode = 0;               // mode x, y or z (0, 1,2)
float px, py;
int[] accel = {0, 0, 0};   // array to store accelerometer values
float[] data = new float[numPoints];
float[] xAxis = new float[numPoints];
 
void setup() {
  println(Serial.list());   // print the serial ports available
  //String comPort = Serial.list()[0];    // should work on linux/mac
  String comPort = Serial.list()[1];    // should work on windows
  port = new Serial(this, comPort, 9600);   // 0 is the first port, you may have to change
  size(800, 600);           // new window
  frame.setTitle("Accelerometer plot");
  reset();
}
 
void draw() {
  while (port.available() > 0) {
    serial = port.readStringUntil('\n');
  }
  if (serial != null) {               // if string is not empty
    String[] a = split(serial, ',');  // split up line with delimiter to be ','
    for(int i = 0; i < a.length; i++) // put all the items in a to be in accel array
      accel[i] = int(a[i]);           // cast to integer, add to array at position i
    drawPlot();
  }
  else {
    println("Could not connect to Esplora! Make sure it is connected to the computer and the correct port is selected!");
    exit();
  }
}
 
void drawPlot() {
  background(255);
  drawBorders();
  if (currentPoint < numPoints) {
    if (millis() - prevTime >= stepSize) {  // check if it is time to plot again
      float x = map(currentPoint, 0, numPoints, offset, width-box);
      float y = map(accel[mode], -512, 512, height, 0);      
      data[currentPoint] = y;
      xAxis[currentPoint] = x;
      if (currentPoint == 0) {        // make the first line just a point
        px =  x;
        py = y;
      }
      text("value: " + accel[mode], width-box-70, box+20);
      for(int i = 1; i < currentPoint; i++) {
        line(xAxis[i-1], data[i-1], xAxis[i], data[i]);
      }
        
      //line(px, py, x, y);             // draw a line from the previous value to current value
      px = x;
      py = y;
      currentPoint++;
      prevTime = millis();
    }
  } 
  else {
    reset();
  }
}
 
// Draw the borders and axes
void drawBorders() {
  fill(255);                          // fill box with white
  strokeWeight(1);
  rectMode(CORNERS);                  // first two args are top left, second two bottom right
  rect(box,box,width-box,height-box);
  strokeWeight(2);
  line(offset, box, offset, height-box);
  line(box, height/2, width-box, height/2);
  fill(0);                            // make text black
  text("time", width - box - 30, height/2+20);
  if (mode == 0)
    text("X axis", offset+5, box+20);
  else if (mode == 1)
    text("Y axis", offset+5, box+20);
  else
    text("Z axis", offset+5, box+20);
  strokeWeight(1);
}
 
// Reset the plot
void reset() {
  background(255);
  currentPoint = 0;
  drawBorders();
}
 
// check if the key is pressed, and change the mode if a new mode is selected
void keyPressed() {
  if ((key == 'x' || key == 'X') && mode != 0) {       // if x OR X is pushed, AND mode is not 0
    mode = 0;
    reset();
  }
  else if ((key == 'y' || key == 'Y') && mode != 1) {  // if y OR Y is pushed, AND mode is not 1
    mode = 1;
    reset();
  }
  else if ((key == 'z' || key == 'Z') && mode != 2) {  // if z OR Z is pushed, AND mode is not 2
    mode = 2;
    reset();
  }

}