/***************************
Plotter labels

Draws 10 labels in a radial pattern
in three different font sizes.

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/

import sjunnesson.HPGL_plotter.*;
import processing.serial.*;

Plotter plotter; // Create a plotter object

//Labels to print
ArrayList labels;

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

  // set the font size to 0.15 cm
  plotter.setFontHeight(0.15);

  // create a label and rotate around 360 degrees
  for (int i = 0; i < 10; ++i) {
    plotter.setLabelDirection(map(i, 0, 10, 0, 360));
    plotter.writeLabel("--SMALL->", plotter.xMax / 2 - 3000, plotter.yMax * 0.25);
  }

  // increase the font size to 0.25cm
  plotter.setFontHeight(0.25);
  for (int i = 0; i < 10; ++i) {
    plotter.setLabelDirection(map(i, 0, 10, 0, 360));
    plotter.writeLabel("--MEDIUM->", plotter.xMax / 2, plotter.yMax * 0.5);
  }

  // and once again increase the font size to 0.35 cm 
  plotter.setFontHeight(0.35);
  for (int i = 0; i < 10; ++i) {
    plotter.setLabelDirection(map(i, 0, 10, 0, 360));
    plotter.writeLabel("--LARGE->", plotter.xMax / 2 + 3000, plotter.yMax * 0.75);
  }

  // put the font back to standard size 
  plotter.setFontHeight(plotter.DEFAULT_FONT_HEIGHT);
  plotter.setLabelDirection(plotter.DEFAULT_LABEL_DIRECTION);
  plotter.writeLabel("LABELS 1", 4800, 1000);
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