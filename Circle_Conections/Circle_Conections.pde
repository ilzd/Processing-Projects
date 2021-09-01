Circle[] circles = new Circle[6];
int radiusStep = 65, countStep = 0, iniCount = 10, iniRadius = 50;
float iniMult = 1.1, multStep = 0.5;

void setup() {
  fullScreen();

  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle(iniCount + countStep * i, iniRadius + radiusStep * i, width / 2, height / 2, color(map(i, 0, circles.length, 0, 255), 0, map(i, 0, circles.length, 255, 0)));
  }
}

void draw() {
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

void backgroundA(int r, int g, int b, int a) {
  noStroke();
  fill(r, g, b, a);
  rect(0, 0, width, height);
}

float distSq(float x1, float y1, float x2, float y2) {
  return pow(x2 - x1, 2) + pow(y2 - y1, 2);
}
