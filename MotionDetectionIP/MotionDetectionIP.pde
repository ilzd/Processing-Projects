import ipcapture.*;
import processing.sound.*;

IPCapture cam;
PImage lastImage, displayImage;
int DIST_THRESHOLD = 4000, MOTION_THRESHOLD = 100;
int motionCount;
SinOsc sin;
boolean connected;
String ip = "192.168.1.102:4747";

void setup() {
  size(640, 600);
  frameRate(30);
  imageMode(CENTER);
  sin = new SinOsc(this);
  fill(0, 255, 255);
  textSize(16);
  textAlign(LEFT, TOP);
}

void draw() {
  if (connected) {
    update();
    text("Color Sensitivity: " + DIST_THRESHOLD + "\nMotion Sentitivity: " + MOTION_THRESHOLD, 0, 0);
  } else {
    background(0);
    text(ip, 0, 0);
  }
}

void connect() {
  connected = true;
  cam = new IPCapture(this, "http://" + ip + "/video", "", "");
  println();
  cam.start();
}

void update() {
  if (cam.isAvailable()) {
    lastImage = cam.copy();
    cam.read();
    displayImage = cam.copy();
    motionCount = 0;
    for (int i = cam.width * 15; i < cam.pixels.length; i++) {
      if (colorDistSq(cam.pixels[i], lastImage.pixels[i]) > DIST_THRESHOLD) {
        motionCount++;
        displayImage.pixels[i] = 255<<24|255<<16|0<<8|0;
      }
    }
    displayImage.updatePixels();
    background(map(motionCount, 0, DIST_THRESHOLD * 2, 0, 255), 0, 0);
    image(displayImage, width / 2, height / 2);
    if (motionCount >= MOTION_THRESHOLD) {
      sin.play(1000, 1);
    } else {
      sin.stop();
    }
  } else if (!cam.isAlive()) {
    sin.play(500, 1);
    delay(1000);
    sin.stop();
    connected = false;
  }
}

void keyPressed() {
  if (!connected) {
    if (key != CODED) {
      switch(key) {
      case ENTER:
        connect();
        break;
      case ' ':
        ip = "";
        break;
      case BACKSPACE:
        if (ip.length() > 0) ip = ip.substring(0, ip.length() - 1);
        break;
      default:
        ip += key;
      }
    }
  } else {
    switch(key) {
    case 'q':
      DIST_THRESHOLD += 200;
      break;
    case 'w':
      DIST_THRESHOLD = max(0, DIST_THRESHOLD - 200);
      break;
    case 'a':
      MOTION_THRESHOLD += 50;
      break;
    case 's':
      MOTION_THRESHOLD = max(0, MOTION_THRESHOLD - 50);
      break;
    default:
      break;
    }
  }
}

float colorDistSq(color c1, color c2) {
  return pow(((c1 >> 16) & 0xFF) - ((c2 >> 16) & 0xFF), 2) + pow(((c1 >> 8) & 0xFF) - ((c2 >> 8) & 0xFF), 2) + pow((c1 & 0xFF) - (c2 & 0xFF), 2);
}
