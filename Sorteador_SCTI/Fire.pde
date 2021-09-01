class Fire {
  float xpos, ypos;
  float xforce;
  float yforce;
  float ygravity = 0.02;
  color c = color(random(180, 255), random(180, 255), random(180, 255));
  float timer = random(0, 200), timer2 = timer;

  Fire(float x, float y, float xf, float yf, color c_) {
    xpos = x;
    ypos = y;
    xforce = xf;
    yforce = yf;
    c = c_;
  }

  void display() {
    strokeWeight(5);
    fill(c, map(timer, 0, timer2, 0, 255));
    stroke(c, map(timer, 0, timer2, 0, 255));
    line(xpos, ypos, xpos + 1 * cos(timer/6), ypos + 1 * sin(timer/6));
    //ellipse(xpos, ypos, 1, 1);
  }

  void move() {
    xpos += xforce;
    ypos += yforce;
    yforce += ygravity;
    timer--;
  }
}
