import processing.video.*;
PImage img, frame;
boolean picTaken = true;
Capture cam;

void setup() {
  size(640, 480);
  img = loadImage("img.jpg");
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, 640, 480, cameras[0], 30);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();

    if (keyPressed) {
      image(cam, 0, 0);
      img = createImage(RGB, width, height);
      img = get(0, 0, width, height);
      picTaken = true;
    }

    frame = cam;

    frame.loadPixels();
    for (int i = 0; i < frame.pixels.length; i++) {
      if (hue(frame.pixels[i]) >= 60 && hue(frame.pixels[i]) <= 130 && saturation(frame.pixels[i]) >= 40 && brightness(frame.pixels[i]) > 30) {
        frame.pixels[i] = color(0, 0);
      }
    }
    frame.updatePixels();

    frame.loadPixels();
    for (int i = 0; i < frame.pixels.length; i++) {
      if (hue(frame.pixels[i]) >= 60 && hue(frame.pixels[i]) <= 130 && saturation(frame.pixels[i]) >= 15 && brightness(frame.pixels[i]) > 15) {
        if ((red(frame.pixels[i]) * blue(frame.pixels[i])) != 0 && (green(frame.pixels[i]) * green(frame.pixels[i])) / (red(frame.pixels[i]) * blue(frame.pixels[i])) >= 1.5) {
          frame.pixels[i] = color((red(frame.pixels[i]) * 1.4), green(frame.pixels[i]), (blue(frame.pixels[i]) * 1.4));
        } else {
          frame.pixels[i] = color((red(frame.pixels[i]) * 1.2), green(frame.pixels[i]), (blue(frame.pixels[i]) * 1.2));
        }
      }
    }
    frame.updatePixels();

    if (picTaken) {
      image(img, 0, 0);
    }

    image(frame, 0, 0);
  }
}

void keyPressed() {
}