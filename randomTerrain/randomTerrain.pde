int size = 5, w = 200, h = 200, variance = 50, extremes = 25;
float t = 0;

void setup() {
  fullScreen(P3D);
  strokeWeight(.5);
}

void draw() {
  background(0);
  camera(0, -500, -500, 0, 0, 0, 0, 1, 0);
  for (int j = -h / 2; j < h / 2; j++) {
    for (int i = -w / 2; i < w / 2; i++) {
      float x1 = i * size, x2 = (i + 1) * size, y1 = j * size, y2 = (j + 1) * size;
      stroke(255, map(noise((x1 / variance), (y1 / variance)), 0, 1, 0, 255), map(noise((x1 / variance), (y1 / variance)), 0, 1, 0, 255));
      line(x1, map(noise((x1 / variance), (y1 / variance)), 0, 1, -extremes, extremes), y1 - t, x2, map(noise((x2 / variance), (y1 / variance)), 0, 1, -extremes, extremes), y1 - t);
      line(x1, map(noise((x1 / variance), (y1 / variance)), 0, 1, -extremes, extremes), y1 - t, x1, map(noise((x1 / variance), (y2 / variance)), 0, 1, -extremes, extremes), y2 - t);
    }
  }
  t += .5;

  if (keyPressed) {
    switch(key) {
    case 'q':
      extremes += 15;
      break;
    case 'w':
      extremes -= 15;
      break;
    case 'a':
      variance -= 15;
      break;
    case 's':
      variance += 15;
      break;
    case 'z':
      t += 10;
      break;
    case 'x':
      t -= 10;
      break;
    default:
      break;
    }
  }
}

void keyPressed() {
}
