/***************************
Select Pen

Draws 6 circles each with a different 
pen to showcase how to select a pen

The max pen is dependent on the plotter 
type and the absolute maximum in the HPGL
language is 255. Normally there is very few plotters
with more then 8 different pens. 

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/


import sjunnesson.HPGL_plotter.*;
import processing.serial.*;

Plotter plotter; // Create a plotter object

//Label to print
String label = "SELECT PEN 1";

void setup() {
  background(233, 233, 220);
  size(900, 640, P3D);
  smooth();

  //Select a serial port
  String portName = Serial.list()[3]; //make sure you pick the right one

  //instantiate the plotter object with 
  //the plotter serial port name, a reference to this PApplet and what type of paper that is being used
  // 0=a4 1=a3 2=A 3=B
  plotter = new Plotter(portName, this, 2);

  plotter.selectPen(1); // select the first pen in the penholder
  plotter.circle(3000, 4000, 750); // draw a circle with that pen

  plotter.selectPen(2); // select second pen
  plotter.circle(4000, 4000, 750);

  plotter.selectPen(3); // third
  plotter.circle(5000, 4000, 750);

  plotter.selectPen(4); // fourth
  plotter.circle(6000, 4000, 750);

  plotter.selectPen(5); // fifth
  plotter.circle(7000, 4000, 750);

  plotter.selectPen(6); // sixth
  plotter.circle(8000, 4000, 750);

  // draw our label for this example
  plotter.writeLabel(label, 4800, 1000);
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