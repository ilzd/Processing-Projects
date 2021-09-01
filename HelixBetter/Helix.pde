class Helix {
  float x, y, vx, vy, a, va, xf, yf, baseRadius, radius, sW;
  color c;
  Helix p;
  boolean attached;

  Helix() {
    this.x = width / 2;
    this.y = height / 2;
    this.radius = 100;
    this.baseRadius = this.radius;
    this.vx = random(-1, 1);
    this.vy = random(-1, 1);
    this.va = random(-0.03, 0.03);
    this.a = random(0, TWO_PI);
    this.c = color(0);
  }

  void setPosition(float x, float y, float a) {
    this.x = x;
    this.y = y;
    this.a = a;
  }

  void setRadius(float radius) {
    this.radius = radius;
    this.baseRadius = radius;
  }

  void setSpeed(float vx, float vy, float va) {
    this.vx = vx;
    this.vy = vy;
    this.va = va;
  }

  void setStyle(color c, float sW) {
    this.c = c;
    this.sW = sW;
  }

  void setParent(Helix p) {
    this.p = p;
    this.attached = true;
  }

  void update() {
    execute();
    display();
  }

  void execute() {
    if (!attached) {
      x += vx;
      if (x < 0 || x > width) vx *= -1;

      y += vy;
      if (y < 0 || y > height) vy *= -1;
    } else {
      x = p.xf;
      y = p.yf;
    }

    a += va;

    radius = map(noise(a / 2), 0, 1, baseRadius * 0.3, baseRadius * 2);

    //if (a > 4) a = 0;
    //if (a < 0) a = 4;

    //if (a < 1) {
    //  xf = x + map(a, 0, 1, -radius / 2, radius / 2);
    //  yf = y - radius / 2;
    //} else if (a < 2) {
    //  xf = x + radius / 2;
    //  yf = y + map(a, 1, 2, -radius / 2, radius / 2);
    //} else if (a < 3) {
    //  xf = x + map(a, 2, 3, +radius / 2, -radius / 2);
    //  yf = y + radius / 2;
    //} else {
    //  xf = x - radius / 2;
    //  yf = y + map(a, 3, 4, radius / 2, -radius / 2);
    //}

    xf = x + sin(a) * radius;
    yf = y + cos(a) * radius;

    //xf = x + (1 + sin(a)) * cos(a) * radius;
    //yf = y + (1 + sin(a)) * sin(a) * radius;
  }

  void display() {
    stroke(c);
    strokeWeight(sW);
    line(x, y, xf, yf);
    //point(x, y);
    //point(xf, yf);
  }
}
