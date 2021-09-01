PImage[] getHorSinMap(int w, int h, int freq, float step) {
  PImage[] images = new PImage[(int)((TWO_PI * freq) / step) + 1];

  int count = 0;

  for (float ang = 0; ang < TWO_PI * freq; ang += step) {
    PImage result = createImage(w, h, RGB);
    for (int x = 0; x < w; x++) {
      float sinValue = sin((x / 75.0) + ang);
      for (int y = 0; y < h; y++) {
        result.pixels[y * w + x] = color(map(sinValue, -1, 1, 0, 255));
      }
    }
    images[count] = result;
    count++;
  }

  return images;
}

PImage[] getVerSinMap(int w, int h, int freq, float step) {
  PImage[] images = new PImage[(int)((TWO_PI * freq) / step) + 1];

  int count = 0;

  for (float ang = 0; ang < TWO_PI * freq; ang += step) {
    PImage result = createImage(w, h, RGB);
    for (int y = 0; y < h; y++) {
      float sinValue = sin((y / 75.0) + ang);
      for (int x = 0; x < w; x++) {
        result.pixels[y * w + x] = color(map(sinValue, -1, 1, 0, 255));
      }
    }
    images[count] = result;
    count++;
  }

  return images;
}

PImage[] getDiagSinMap(int w, int h, int freq, float step) {
  PImage[] images = new PImage[(int)((TWO_PI * freq) / step) + 1];

  int count = 0;

  for (float ang = 0; ang < TWO_PI * freq; ang += step) {
    PImage result = createImage(w, h, RGB);
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        float sinValue = sin(((x + y) / 75.0) + ang);
        result.pixels[y * w + x] = color(map(sinValue, -1, 1, 0, 255));
      }
    }
    images[count] = result;
    count++;
  }

  return images;
}

PImage[] getRadialSinMap(int w, int h, int freq, float step) {
  PImage[] images = new PImage[(int)((TWO_PI * freq) / step) + 1];

  int count = 0;

  for (float ang = 0; ang < TWO_PI * freq; ang += step) {
    PImage result = createImage(w, h, RGB);
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        float sinValue = tan((dist(x, y, w / 2, h / 2) / 100.0) - ang);
        result.pixels[y * w + x] = color(map(sinValue, -1, 1, 0, 255));
      }
    }
    images[count] = result;
    count++;
  }

  return images;
}
