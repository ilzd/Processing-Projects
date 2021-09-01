class Fogo {
  float xpos, ypos;
  float xforce = random(-3, 3);
  float yforce = random(-3, 3);
  float ygravity = 0.02;
  color c = color(random(255), random(255), random(255));
  float timer = random(1000, 2000), timer2 = timer;

  Fogo(float x, float y) {
    xpos = x;
    ypos = y;
  }

  void display() {
    strokeWeight(1);
    fill(c, map(timer, 0, timer2, 0, 255));
    stroke(c, map(timer, 0, timer2, 0, 255));
    //line(xpos, ypos, xpos + 2 * cos(timer/6), ypos + 2 * sin(timer/6));
    ellipse(xpos, ypos, 1, 1);
  }

  void move() {
    xpos += xforce;
    ypos += yforce;
    //yforce += ygravity;
    timer--;
  }
}
