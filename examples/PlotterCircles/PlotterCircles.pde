/***************************
Plotter circles

Draws 6 sets of circles with 10 circles in each set
with different resolution. 

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/


import sjunnesson.HPGL_plotter.*;
import processing.serial.*;

Plotter plotter; // Create a plotter object

//Label to print
String label = "CIRCLES 1";

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

  for (int i = 0; i < 10; ++i) {
    plotter.circle(3000 + i * 50, 2000 + i * 50, 500); // resolution defaults to 0.5
    plotter.circle(5000 + i * 50, 2000 + i * 50, 500, 5);
    plotter.circle(7000 + i * 50, 2000 + i * 50, 500, 10);

    plotter.circle(3000 + i * 50, 5000 + i * 50, 500, 15);
    plotter.circle(5000 + i * 50, 5000 + i * 50, 500, 30);
    plotter.circle(7000 + i * 50, 5000 + i * 50, 500, 45);
  }
  plotter.writeLabel(label, 4800, 1000);
}

void draw(){
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

