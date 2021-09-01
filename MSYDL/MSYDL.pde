import processing.video.*;
import processing.sound.*;

static final float BOUNDS_MULTPIPLIER = .05; //DEFINE A BORDA "NÃO" JOGAVEL DA TELA

Capture cam;
PImage frame;
Activity act = new FirstActivity(-1);
int minBoundX, maxBoundX, minBoundY, maxBoundY;
ArrayList<Player> players = new ArrayList<Player>();
Player mainPlayer;

void setup() {
  fullScreen();

  frameRate(60);

  cam = new Capture(this, 640, 480, 30);

  frame = createImage(cam.width, cam.height, RGB);

  cam.start();

  minBoundX = (int)(width * BOUNDS_MULTPIPLIER);
  maxBoundX = width - (int)(width * BOUNDS_MULTPIPLIER);
  minBoundY = (int)(height * BOUNDS_MULTPIPLIER);
  maxBoundY = height - (int)(height * BOUNDS_MULTPIPLIER);
}

void draw() {
  camUpdate(cam);

  act.update();

  for (Player p : players) {
    p.manageBlobs();
  }

  drawBounds();
}



Capture flipCaptureHorizontaly(Capture cam) {
  for (int i = 0; i < cam.width / 2; i++) {
    for (int j = 0; j < cam.height; j++) {
      color aux = cam.pixels[j * cam.width + i];
      cam.pixels[j * cam.width + i] = cam.pixels[j * cam.width + cam.width - i - 1];
      cam.pixels[j * cam.width + cam.width - i - 1] = aux;
    }
  }

  return cam;
}

void camUpdate(Capture c) {
  if (c != null && c.available()) {
    c.read();
    frame = flipCaptureHorizontaly(c);
  }
}

void drawBounds() {
  noFill();
  stroke(255);
  strokeWeight(1);
  rect(minBoundX, minBoundY, maxBoundX - minBoundX, maxBoundY - minBoundY);
}

void resetPlayerState() {
  for (Player p : players) {
    p.active = true;
  }
}

class Point {
  float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

//Distancia entre duas cores elevada ao quadrado
float distSq(color c1, color c2) {
  float r1 = (c1 >> 16) & 0xFF;
  float g1 = (c1 >> 8) & 0xFF;
  float b1 = c1 & 0xFF;
  float r2 = (c2 >> 16) & 0xFF;
  float g2 = (c2 >> 8) & 0xFF;
  float b2 = c2 & 0xFF;

  return distSq(r1, g1, b1, r2, g2, b2);
}

//Distancia entre dois pontos no espaço elevado ao quadrado
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  return pow(x2 - x1, 2) + pow(y2 - y1, 2) + pow(z2 - z1, 2);
}

//Distancia entre dois pontos no plano elevado ao quadrado
float distSq(float x1, float y1, float x2, float y2) {
  return pow(x2 - x1, 2) + pow(y2 - y1, 2);
}

//Distancia entre dois pontos na reta ao quadrado
float distSq(float x1, float x2) {
  return pow(x2 - x1, 2);
}
