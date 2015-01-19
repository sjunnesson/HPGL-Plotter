/***************************
Plotter bezier curve example

Draws a 4 point bezier curve on screen
and when 'p' is pressed it will plot it. 

Detail level of the bezier is set by the 
mouse position

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/


import sjunnesson.HPGL_plotter.*;
import processing.serial.*;

Plotter plotter; // Create a plotter object

//Label to print
String label = "BEZIER 1";

int x1 = 10;
int y1 = 10;

int cx1 = 500;
int cy1 = 10;

int cx2 = 490;
int cy2 = 350;

int x2 = 490;
int y2 = 490;

int bDetail=10;

void setup() {
  background(233, 233, 220);
  size(900, 700, P3D);
  smooth();
  noFill();
  //Select a serial port
  String portName = Serial.list()[3]; //make sure you pick the right one

  //instantiate the plotter object with 
  //the plotter serial port name, a reference to this PApplet and what type of paper that is being used
  // 0=a4 1=a3 2=A 3=B
  plotter = new Plotter(portName, this, 2);
}


void draw() {
  background(233, 233, 220);

  // draw a bezier with max details
  bezierDetail(20);
  stroke(120, 120, 0);
  bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);

  // draw a bezier with the detail depending on mouse
  bDetail = int(map(mouseX, 0, 900, 1, 20));
  bezierDetail(bDetail);
  stroke(0, 120, 120);
  bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);

  // draw out the bezier points 
  ArrayList linePoints = getBezierPoint(x1, y1, cx1, cy1, cx2, cy2, x2, y2, bDetail);
  stroke(120, 0, 120);
  for (int i = 0; i < linePoints.size(); i++) {
    PVector ellipsePos = (PVector) linePoints.get(i);
    ellipse((float) ellipsePos.x, (float) ellipsePos.y, 10, 10);
  }
}

void keyPressed() {
  if (key == 'p') {
    println("Plotting bezier with detail level: "+bDetail);
    plotter.bezierDetail(bDetail);
    plotter.bezier(x1*10, y1*10, cx1*10, cy1*10, cx2*10, cy2*10, x2*10, y2*10);
    plotter.writeLabel(label, plotter.xMin + 500, plotter.yMax - 500);
  }
}


ArrayList getBezierPoint(int point1x, int point1y, int point2x, int point2y, int point3x, int point3y, int point4x, int point4y, float detail) {
  ArrayList points = new ArrayList();
  float increment = 1 / detail;

  for (float t = 0.00; t < 1.01; t = t + increment) {

    double xValue = Math.pow((1 - t), 3) * point1x + 3 * Math.pow((1 - t), 2) * t * point2x + 3 * (1 - t) * Math.pow(t, 2) * point3x + Math.pow(t, 3) * point4x;
    double yValue = Math.pow((1 - t), 3) * point1y + 3 * Math.pow((1 - t), 2) * t * point2y + 3 * (1 - t) * Math.pow(t, 2) * point3y + Math.pow(t, 3) * point4y;
    points.add(new PVector((float) xValue, (float) yValue));
  }
  return points;
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