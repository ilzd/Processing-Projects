void setup() {
  fullScreen();
  stroke(255);
  strokeWeight(1);
  noFill();
}

void draw() {
  background(0);
  circle(width / 2, height / 2, map(mouseX, 0, width, 50, 250));
}

void circle(float x, float y, float rad) {
  if (rad > 8) {
    ellipse(x, y, rad * 2, rad * 2);
    circle(x - rad, y, rad * 0.5);
    circle(x + rad, y, rad * 0.5);
    circle(x, y - rad, rad * 0.5);
    circle(x, y + rad, rad * 0.5);
  }
}
