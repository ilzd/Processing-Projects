PImage background, cover;
int x, y, radius = 120;

void setup() {
  fullScreen();

  background = loadImage("img.jpeg");

  float prop = min((float)width / background.width, (float)height / background.height);
  background.resize((int)(background.width * prop), (int)(background.height * prop));

  x = width / 2 - background.width / 2;
  y = height / 2 - background.height / 2;

  cover = createImage(background.width, background.height, RGB);
  background(0);
}

void draw() {
  image(background, x, y);
  image(cover, x, y);

  if (mousePressed) {
    deleteImage(mouseX - x, mouseY - y, radius);
  }

  color c;
  int a;
  for (int i = 0; i < cover.pixels.length; i++) {
    c = cover.pixels[i];
    a = (c >> 24) & 0xFF;
    if (a < 255) cover.pixels[i] = (a + 3) << 24 | 0 << 16 | 0 << 8 | 0;
  }

  cover.updatePixels();
}

void deleteImage(int px, int py, int radius) {
  int deltaY;
  for (int i = px - radius; i < px + radius; i++) {
    if (i > 0 && i < cover.width) {
      deltaY = round(sqrt(pow(radius, 2) - pow(i - px, 2)));
      for (int j = py - deltaY; j < py + deltaY; j++) {
        if (j > 0 && j < cover.height) {
          cover.pixels[j * cover.width + i] = 0 >> 24 | 0 >> 16 | 0 >> 8 | 0;
        }
      }
    }
  }
}
