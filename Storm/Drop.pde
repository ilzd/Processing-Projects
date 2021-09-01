class Drop {
  float z = random(0, 1);
  float xspd =1.7;
  float yspd = map(z, 0, 1, 20, 5);
  float ysize = map(z, 0, 1, 15, 3);
  float xsize = map(z, 0, 1, 3, 0.5);
  float x = random((-height / yspd) * xspd, width);
  float y = random(-ysize, height);
  color cor = color(random(50, 150), random(100, 200), random(200, 255));

  void Move() {
    y += yspd;
    x += xspd;
    if (y > height) {
      y = -ysize;
      x = random((-height / yspd) * xspd, width);
    }
  }

  void Display() {
    stroke(cor);
    strokeWeight(xsize);
    line(x, y, x, y + ysize);
  }
}