ArrayList<Fire> fires = new ArrayList();
ArrayList<Bomb> bombs = new ArrayList();
PImage img;

void setup() {
  fullScreen();
  background(0);
  img = loadImage("ac.jpg");
}

void draw() {
  noStroke();
  fill(0, 80);
  rect(0, 0, width, height);
  for (int i = 0; i < fires.size(); i++) {
    Fire fire = fires.get(i);
    fire.move();
    fire.display();
  }

  for (int i = 0; i < bombs.size(); i++) {
    Bomb bomb = bombs.get(i);
    bomb.move();
    bomb.display();
    if (bomb.time == bomb.duration) {
      iDontKnow(bomb.x, bomb.y);
      bombs.remove(i);
    }
  }
}

void mousePressed() {
  bombs.add(new Bomb(mouseX, mouseY, random(-1, 1), random(-5, -10), 150));
}

void iDontKnow(float x, float y) {
  int pix = (int)map(mouseX, 0, width, 5, 150);
  int tempR = 0, tempG = 0, tempB = 0;
  int translateX = (width - img.width) / 2;
  int translateY = (height - img.height) / 2;
  for (int i = 0; i < pix; i++) {
    for (int j = 0; j < pix; j++) {
      tempR = 0;
      tempG = 0;
      tempB = 0;
      for (int k = (img.width / pix) * i; k < (img.width / pix) * (i + 1); k++) {
        for (int l = (img.height / pix) * j; l < (img.height / pix) * (j + 1); l++) {
          tempR += red(img.pixels[l * img.width + k]);
          tempG += green(img.pixels[l * img.width + k]);
          tempB += blue(img.pixels[l * img.width + k]);
        }
      }
      int tempX = i * (img.width / pix) + (int)random(-(img.width / pix) / 2, (img.width / pix) / 2) + translateX;
      int tempY = j * (img.height / pix) + (int)random(-(img.height / pix) / 2, (img.height / pix) / 2) + translateY;
      int asd = (int)random(10, 50);
      fires.add(new Fire(x, y, (tempX - x) / asd, (tempY - y) / asd, asd, color(tempR / (img.width / pix) / (img.height / pix), tempG / (img.width / pix) / (img.height / pix), tempB / (img.width / pix) / (img.height / pix)), img.width / pix));
    }
  }
}
