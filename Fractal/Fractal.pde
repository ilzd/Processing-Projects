float dAng, dSize;

void setup() {
  fullScreen();
  strokeWeight(0.5);
}

void draw() {
  background(0);
  dAng = map(mouseX, 0, width, 0, PI);
  dSize = map(mouseY, 0, height, 1.5, 2);
  branch(width / 2, height / 2, 200 / dSize, -PI / 2);
}

void branch(float x, float y, float size, float ang) {
  stroke(255, 0, 0);
  line(x, y, x + cos(ang - dAng) * size, y + sin(ang - dAng) * size);
  stroke(0, 255, 0);
  line(x, y, x + cos(ang) * size, y + sin(ang) * size);
  stroke(0, 0, 255);
  line(x, y, x + cos(ang + dAng) * size, y + sin(ang + dAng) * size);

  if (size > 10) {
    branch(x + cos(ang - dAng) * size, y + sin(ang - dAng) * size, size / dSize, ang - dAng);
    branch(x + cos(ang) * size, y + sin(ang) * size, size / 2, ang);
    branch(x + cos(ang + dAng) * size, y + sin(ang + dAng) * size, size / dSize, ang + dAng);
  }
}
