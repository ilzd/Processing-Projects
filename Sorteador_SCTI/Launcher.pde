class Launcher {
  float xpos, ypos;
  float xforce = random(-2, 2);
  float yforce = -6;
  float ygravity = 0.02;
  color c = color(255, 255, 0);
  float timer = random(80, 100), timer2 = timer;

  Launcher(float x, float y) {
    xpos = x;
    ypos = y;
  }

  void display() {
    strokeWeight(10);
    fill(c, map(timer, 0, timer2, 0, 255));
    stroke(c, map(timer, 0, timer2, 0, 255));
    point(xpos, ypos);
  }

  void move() {
    xpos += xforce;
    ypos += yforce;
    yforce += ygravity;
    timer--;
    if (timer <= 0) {
      color c = color(random(0, 255), random(0, 255), random(0, 255));
      for (int i = 0; i < points.size(); i++) {
        fires.add(new Fire(xpos, ypos, points.get(i).x / 30, points.get(i).y / 30, c));
      }
    }
  }
}
