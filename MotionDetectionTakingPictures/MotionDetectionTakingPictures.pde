import processing.video.*;

Capture cam;
PImage last, movement;
int minDistSq = 9500;
int movementThreshold = 150;
int timerMax = 150, timer = timerMax;

void setup() {
  size(1280, 480);
  frameRate(30);
  
  textSize(32);
  fill(255, 0, 0);

  String[] webcams = Capture.list();

  for (String webcam : webcams) {
    println(webcam);
  }

  cam = new Capture(this, 640, 480, 30);
  movement = new PImage(cam.width, cam.height, RGB);
  cam.start();
}

void draw() {
  if (cam.available()) {
    last = cam.copy();
    cam.read();

    float dist;
    int movementCount = 0;
    for (int i = 0; i < last.pixels.length; i++) {
      dist = colorDistSq(last.pixels[i], cam.pixels[i]);
      if (dist > minDistSq) {
        movementCount++;
        movement.pixels[i] = 255<<24|255<<16|0<<8|0;
      } else {
        movement.pixels[i] = 255<<24|0<<16|0<<8|0;
      }
    }
    movement.updatePixels();
    image(cam, 0, 0);
    image(movement, 640, 0);
    text("" + movementCount, 20, 52);
    if (movementCount > movementThreshold) {
      if (timer == timerMax) {
        saveFrame("pictures/frame####.pgn");
        timer = 0;
      }
    }
  }

  if (timer < timerMax) timer++;
}

float colorDistSq(color c1, color c2) {
  return pow(((c1 >> 16) & 0xFF) - ((c2 >> 16) & 0xFF), 2) + pow(((c1 >> 8) & 0xFF) - ((c2 >> 8) & 0xFF), 2) + pow((c1 & 0xFF) - (c2 & 0xFF), 2);
}
