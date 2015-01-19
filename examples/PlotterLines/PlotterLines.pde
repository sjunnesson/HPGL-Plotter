/***************************
Plotter lines example

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/


import sjunnesson.HPGL_plotter.*;
import processing.serial.*;

Plotter plotter; // Create a plotter object

//Label to print
String label = "LINES 1";


void setup() {
  background(233, 233, 220);
  size(900, 700, P3D);
  smooth();
  //Select a serial port
  String portName = Serial.list()[3]; //make sure you pick the right one

  //instantiate the plotter object with 
  //the plotter serial port name, a reference to this PApplet and what type of paper that is being used
  // 0=a4 1=a3 2=A 3=B
  plotter = new Plotter(portName, this, 2);

  // set the stroke for the on screen lines
  stroke(126);

  int numLines = 50;
  // loop over to plot lines with different length
  for (int i = 0; i <= numLines; i++) {
    // draw it on the plotter
    plotter.line(plotter.xMax / 2, ((plotter.yMax / numLines) * i), (i * (plotter.xMax / numLines)), ((plotter.yMax / numLines) * i));
    // draw it on screen
    line(width / 2, ((height / numLines) * i), (i * (width / numLines)), ((height / numLines) * i));
  }
  // draw a diagonal line
  plotter.line(0, 0, plotter.xMax, plotter.yMax);
  line(0, 0, width, height);

  // plot the label for this example
  plotter.writeLabel(label, plotter.xMin+500, plotter.yMax-500);
}

void draw() {
  // an all empty Draw loop since all the drawings is done in the setup
}

void serialEvent(Serial p) {
  char serialChar = p.readChar();

  if (serialChar == 19) {
    plotter.bufferFull = true;
    println("Buffer full");
  }
  if (serialChar == 17) {
    plotter.bufferFull = false;
    println("Buffer empty");
  }
}