RDImage img1 = new RDImage(5, 30, 20);
RDImage img2 = img1.copy();

void setup() {
  size(400, 300);

  img2.shiftRect(10, 10, 9, 10);

  noLoop();
}

void draw() {
  img1.display(0, 0);
  img2.display(120, 0);
}
