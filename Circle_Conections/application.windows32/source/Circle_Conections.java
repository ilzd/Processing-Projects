import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Circle_Conections extends PApplet {

Circle[] circles = new Circle[7];
int radiusStep = 65, countStep = 0, iniCount = 10, iniRadius = 50;
float iniMult = 1.1f, multStep = 0.5f;

public void setup() {
  

  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle(iniCount + countStep * i, iniRadius + radiusStep * i, width / 2, height / 2, color(map(i, 0, circles.length, 0, 255), 0, map(i, 0, circles.length, 255, 0)));
  }
}

public void draw() {
  backgroundA(0, 0, 0, 40);
  //background(0);
  for (Circle c : circles) {
    c.update();
  }

  for (int i = 0; i < circles.length - 1; i++) {
    float dist = (circles[i + 1].radius + circles[i + 1].auxRadius) - (circles[i].radius + circles[i].auxRadius);
    circles[i].displayConnections(circles[i + 1], dist * dist, dist * dist * (iniMult + multStep * i));
  }
}

public void backgroundA(int r, int g, int b, int a) {
  noStroke();
  fill(r, g, b, a);
  rect(0, 0, width, height);
}

public float distSq(float x1, float y1, float x2, float y2) {
  return pow(x2 - x1, 2) + pow(y2 - y1, 2);
}
class Circle {
  Node[] nodes;
  float ang, angV, t = random(0, 1), s = random(0, 40), vs = random(0.05f, 0.1f);
  float radius, auxRadius = 0;
  float px, py;
  int cor;

  Circle(int nodeCount, float radius, float px, float py, int c) {
    this.cor = c;
    this.radius = radius;
    this.px = px;
    this.py = py;
    nodes = new Node[nodeCount];
    for (int i = 0; i < nodes.length; i++) {
      nodes[i] = new Node(c, 3);
    }
  }

  public void update() {
    process();
    display();
  }

  public void process() {
    t += random(-0.2f, 0.2f);
    angV = map(noise(t), 0, 1, -0.01f, 0.01f);
    ang += angV;

    s += vs;
    if (s < 0 || s > 40) vs *= -1;
    auxRadius = map(s, 0, 40, -radius / 10, radius / 10);

    float baseAng;
    for (int i = 0; i < nodes.length; i++) {
      baseAng = map(i, 0, nodes.length - 1, 0, TWO_PI);
      nodes[i].px = px + cos(baseAng + ang) * (radius + auxRadius);
      nodes[i].py = py + sin(baseAng + ang) * (radius + auxRadius);
    }
  }

  public void display() {
    for (Node n : nodes) {
      n.display();
    }
    //noFill();
    //stroke(cor);
    //strokeWeight(0.1);
    //ellipse(px, py, radius * 2, radius * 2);
  }

  public void displayConnections(Circle c, float min, float max) {
    stroke(cor);
    for (Node n1 : nodes) {
      for (Node n2 : c.nodes) {
        float dist = distSq(n1.px, n1.py, n2.px, n2.py);
        if (dist < max) {
          strokeWeight(map(dist, min, max, 0.1f, 0));
          line(n1.px, n1.py, n2.px, n2.py);
        }
      }
    }
  }
}

class Node {
  float px, py;
  float radius;
  int c;

  Node(int c, float radius) {
    this.radius = radius;
    this.c = c;
  }

  public void display() {
    noStroke();
    fill(c);
    ellipse(px, py, radius * 2, radius * 2);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Circle_Conections" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
