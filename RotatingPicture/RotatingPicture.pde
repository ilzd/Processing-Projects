PImage img;

void setup () {
  size(400, 400);
  img = loadImage("image.jpg");
}

void draw() {
  background(img);
}

void mousePressed() {
  PImage temp = img.get();
  img.loadPixels();
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int pos = i + j * img.width;
      int rotatepos = img.width - 1 - j + i * img.width;
      if (mouseButton == LEFT) {
        temp.pixels[rotatepos] = img.pixels[pos];
      }
      if (mouseButton == RIGHT) {
        temp.pixels[pos] = img.pixels[rotatepos];
      }
    }
  }
  img.updatePixels();
  img = temp.get();
}