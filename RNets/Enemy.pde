class Enemy {
  float px, py, ox, oy, ovx, ovy;
  float vx = random(-2, 2), vy = random(-2, 2);
  int radius = 25;

  Enemy() {
    hardReset();
    reset();
  }

  void hardReset() {
    ox = width / 2;
    oy = height / 2;
    float dir = random(0, TWO_PI);
    ox += cos(dir) * width / 2;
    oy += sin(dir) * height / 2;
    ovx = random(-2, 2);
    ovy = random(-2, 2);
  }

  void reset() {
    //hardReset();

    px = ox;
    py = oy;
    vx = ovx;
    vy = ovy;
  }

  void move() {
    px += vx;
    py += vy;
    if (px < 0 || px > width) {
      vx *= -1;
    }
    if (py < 0 || py > height) {
      vy *= -1;
    }
  }

  void display() {
    fill(255, 0, 0);
    ellipse(px, py, radius * 2, radius * 2);
  }
}
