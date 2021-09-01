import ipcapture.*;
import processing.sound.*;
SinOsc sin;
int captureW, captureH;
EditText editIp, editPort, editUser, editPass;
boolean connected = false;
IPCapture cam;
PImage lastImage, movementImg;
int minColorDist = 900;

void setup() {
  size(640, 480);
  background(0);
  captureW = width / 2;
  captureH = height;
  lastImage = createImage(captureW, captureH, RGB);
  textSize(50);
  sin = new SinOsc(this);

  editIp = new EditText(0, 0, 150, 20, "192.168.1.3", false);
  editPort = new EditText(150, 0, 150, 20, "4747", false);
  editUser = new EditText(300, 0, 150, 20, "", false);
  editPass = new EditText(450, 0, 150, 20, "", true);

  connectToCamera();

  movementImg = createImage(captureW, captureH, RGB);
}

void draw() {
  if (cam != null) {
    checkMovement();
  }
  drawUI();
}

void drawUI() {
  if (!connected) {
    editIp.display();
    editPort.display();
    editUser.display();
    editPass.display();
    fill(255);
    text("Press ENTER to connect", 2, 40);
  } else {
    fill(255);
    text("Press BACKSPACE to disconnect", 2, 20);
  }
}

void checkMovement() {
  if (cam.isAvailable()) {
    lastImage.copy(cam, 0, 0, cam.width, cam.height, 0, 0, lastImage.width, lastImage.height);
    cam.read();
    image(cam, 0, 0);

    int count = 0;
    for (int x = 0; x < movementImg.width; x++) {
      for (int y = 11; y < movementImg.height; y++) {
        color lastC = lastImage.pixels[y * lastImage.width + x];
        color c = cam.pixels[y * cam.width + x];
        if (distSq((lastC >> 16) & 0xFF, (lastC >> 8) & 0xFF, (lastC) & 0xFF, 
          (c >> 16) & 0xFF, (c >> 8) & 0xFF, c & 0xFF) > minColorDist) {
          movementImg.pixels[y * lastImage.width + x] = color(255, 0, 0);
          count++;
        } else {
          movementImg.pixels[y * lastImage.width + x] = color(0);
        }
      }
    }
    movementImg.updatePixels();
    image(movementImg, captureW, 0);
    if (count > 500) {
      sin.play(1000, 1);
    } else {
      sin.stop();
    }
    fill(255);
    text("" + count, 650, height - 10);
  }
}

void connectToCamera() {
  cam = new IPCapture(this, "http://" + editIp.text + ":" + editPort.text + "/video", editUser.text, editPass.text);
  cam.start();
}

void keyPressed() {
  sin.stop();
  if (keyCode == ENTER && !connected) {
    background(0);
    connected = true;
    connectToCamera();
  } else if (keyCode == BACKSPACE && connected) {
    background(0);
    try {
      cam.stop();
    } 
    catch (Exception e) {
    }
    cam = null;
    connected = false;
  } else {
    editIp.updateText(key);
    editPort.updateText(key);
    editUser.updateText(key);
    editPass.updateText(key);
  }
}

void mousePressed() {
  editIp.updateActive();
  editPort.updateActive();
  editUser.updateActive();
  editPass.updateActive();
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1);
}
