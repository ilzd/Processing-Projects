Point p1 = new Point(), p2 = new Point(), p3 = new Point(), p4 = new Point(), p;
boolean selected = false;

void setup() {
  size(600, 600);
  stroke(255);
  strokeWeight(2);
}

void draw() {
  background(0);
  if (selected) {
    p.x = mouseX;
    p.y = mouseY;
  }

  noFill();
  bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);

  fill(255, 0, 0);
  ellipse(p1.x, p1.y, 10, 10);
  ellipse(p4.x, p4.y, 10, 10);

  fill(0, 255, 0);
  ellipse(p2.x, p2.y, 10, 10);
  ellipse(p3.x, p3.y, 10, 10);
}

void mousePressed() {
  if (selected) {
    selected = false;
  } else {
    if (dist(mouseX, mouseY, p1.x, p1.y) < 10) {
      p = p1;
      selected = true;
    } else if (dist(mouseX, mouseY, p2.x, p2.y) < 10) {
      p = p2;
      selected = true;
    } else if (dist(mouseX, mouseY, p3.x, p3.y) < 10) {
      p = p3;
      selected = true;
    } else if (dist(mouseX, mouseY, p4.x, p4.y) < 10) {
      p = p4;
      selected = true;
    }
  }
}

class Point {
  float x = random(0, 255), y = random(0, 255);
}
