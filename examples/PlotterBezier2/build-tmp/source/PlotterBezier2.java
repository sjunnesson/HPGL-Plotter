import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import sjunnesson.HPGL_plotter.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PlotterBezier2 extends PApplet {

/***************************
Plotter bezier curve example 2

Draws 4 point bezier curves on screen with
different detail levels and when 'p' is 
pressed it will plot it. 

made by: david sjunnesson
2015
sjunnesson@gmail.com
***************************/





Plotter plotter; // Create a plotter object

//Label to print
String label = "BEZIER 2";

int x1 = 850;
int y1 = 100;

int cx1 = 100;
int cy1 = 100;

int cx2 = 800;
int cy2 = 800;

int x2 = 50;
int y2 = 600;

int bDetail = 10;

int numberCurves=100;

public void setup() {
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


public void draw() {
  background(233, 233, 220);

  for (int i = 0; i < numberCurves; ++i) {
    bezierDetail(i);
    stroke(0, 120, 120);
    bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
  }

}

public void keyPressed() {
  if (key == 'p') {
    for (int i = 0; i < 100 ; ++i) {
      plotter.bezierDetail(i);
      plotter.bezier(x1 * 10, y1 * 10, cx1 * 10, cy1 * 10, cx2 * 10, cy2 * 10, x2 * 10, y2 * 10);
    }
    plotter.writeLabel(label, plotter.xMin + 500, plotter.yMax - 500);
  }
}


public ArrayList getBezierPoint(int point1x, int point1y, int point2x, int point2y, int point3x, int point3y, int point4x, int point4y, float detail) {
  ArrayList points = new ArrayList();
  float increment = 1 / detail;

  for (float t = 0.00f; t < 1.01f; t = t + increment) {

    double xValue = Math.pow((1 - t), 3) * point1x + 3 * Math.pow((1 - t), 2) * t * point2x + 3 * (1 - t) * Math.pow(t, 2) * point3x + Math.pow(t, 3) * point4x;
    double yValue = Math.pow((1 - t), 3) * point1y + 3 * Math.pow((1 - t), 2) * t * point2y + 3 * (1 - t) * Math.pow(t, 2) * point3y + Math.pow(t, 3) * point4y;
    points.add(new PVector((float) xValue, (float) yValue));
  }
  return points;
}



public void serialEvent(Serial p) {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PlotterBezier2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
