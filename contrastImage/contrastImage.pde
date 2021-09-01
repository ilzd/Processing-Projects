void setup() {
  PImage image = loadImage("6.png");

  image.loadPixels();
  for (int i = 0; i < image.pixels.length; i++) {
    if (brightness(image.pixels[i]) > 150) {
      image.pixels[i] = color(255);
    } else {
      image.pixels[i] = color(0);
    }
  }
  image.updatePixels();

  image.save("teste.png");
}

void draw() {
}
