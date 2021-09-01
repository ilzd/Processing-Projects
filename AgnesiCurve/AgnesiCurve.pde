Agnesi agn;

void setup() {
  fullScreen();
  frameRate(120);

  agn = new Agnesi(width / 2, height / 2 + height / 6, width, height, height / 6);
}

void draw() {
  background(180);
  agn.display();
}
