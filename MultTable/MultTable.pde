int nailCount = 10;
int mult = 2;
Point[] nails;
int size = 500;
int wait = 0;

void setup() {
  fullScreen(P2D);
  smooth(8);
  textAlign(CENTER, CENTER);
  frameRate(60);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  createNails();
  drawNails();
  drawLines();
  textSize(32);
  text("Pontos: " + nailCount, 0, -height / 2.2);
  text("Multiplicador: " + mult, 0, -height / 2.4);

  if (keyPressed && wait < 0) {
    wait = 8;
    if (key == 'q' || key == 'Q') {
      nailCount = max(2, nailCount - 1);
    } else if (key == 'w' || key == 'W') {
      nailCount++;
    } else if (key == 'a' || key == 'A') {
      mult = max(2, mult - 1);
    } else if (key == 's' || key == 'S') {
      mult++;
    }
  }

  wait--;
}

void createNails() {
  nails = new Point[nailCount];
  float ang = TWO_PI / nailCount;
  float radius = size / 2;
  textSize(14);
  for (int i = 0; i < nailCount; i++) {
    nails[i] = new Point(radius * cos(ang * i), radius * sin(ang * i));
    text(i, radius * cos(ang * i) * 1.1, radius * sin(ang * i) * 1.1);
  }
}

void drawNails() {
  stroke(255);
  noFill();
  strokeWeight(1);
  ellipse(0, 0, size, size);
  stroke(255, 0, 0);
  strokeWeight(5);
  for (int i = 0; i < nailCount; i++) {
    point(nails[i].x, nails[i].y);
  }
}

void drawLines() {
  stroke(255, 255, 0);
  strokeWeight(1);
  for (int i = 0; i < nailCount; i++) {
    line(nails[i].x, nails[i].y, nails[(i * mult) % nailCount].x, nails[(i * mult) % nailCount].y);
  }
}

void keyPressed() {
}
