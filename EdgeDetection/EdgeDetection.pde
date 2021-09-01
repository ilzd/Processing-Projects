import processing.video.*;

Capture cam;

int maxColorDif = 40;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480, 30);
  cam.start();
}

void draw() {
  PImage edgesImg = createImage(cam.width, cam.height, RGB);  
  for (int x = 1; x < cam.width - 1; x++) {
    for (int y = 1; y < cam.height - 1; y++) {
      boolean isEdge = false;
      color actualPixel = cam.pixels[y * cam.width + x];
      for (int i = x - 1; i < x + 2; i++) {
        for (int j = y - 1; j < y + 2; j++) {
          color arroundPixel = cam.pixels[j * cam.width + i];
          if (distSq(red(actualPixel), green(actualPixel), blue(actualPixel), red(arroundPixel), green(arroundPixel), blue(arroundPixel)) > maxColorDif * maxColorDif) {
            isEdge = true;
            //break;
          }
        }
        if (isEdge) {
          //break;
        }
      }
      edgesImg.loadPixels();
      if (isEdge) {
        edgesImg.pixels[y * edgesImg.width + x] = color(255);
      } else {
        edgesImg.pixels[y * edgesImg.width + x] = color(0);
      }
    }
  }
  image(edgesImg, 0, 0);
}

void captureEvent(Capture c) {
  c.read();
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1);
}