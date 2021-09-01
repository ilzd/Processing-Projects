float t = 0;

void setup() {
  size(600, 600);
  background(30);
}

void draw() {
  background(30);
  for(int i = 0; i < map(mouseY, 0, height, 1, 30); i++){
    drawLine(2 * x(t + i), y(t + i), x(t + i), 2 * y(t + i));
  }
  //drawPoint(2 * x(t), y(t));
  //drawPoint(x(t), 2 * y(t));
  //drawLine(2 * x(t), y(t), x(t), 2 * y(t));
  t += map(mouseX, 0, width, 0, 0.2);
}

void drawPoint(float x, float y) { 
  stroke(255, 120, 120);
  strokeWeight(3);
  point(width / 2 + x, height / 2 + y);
}

void drawLine(float x1, float y1, float x2, float y2) {
  stroke(255, 120, 120);
  strokeWeight(3);
  line(width / 2 + x1, height / 2 + y1, width / 2 + x2, height / 2 + y2);
}

float x(float t) {
  return 100 * sin(t / 5);
}

float y(float t) {
  return 100 * cos(t / 5);
}