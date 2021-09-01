class Lancador {
  float xpos, ypos;
  float xforce = random(-2, 2);
  float yforce = random(-8, -3);
  float ygravity = 0.05;
  color c = color(255, 255, 0);
  float timer = random(80, 100), timer2 = timer;

  Lancador(float x, float y) {
    xpos = x;
    ypos = y;
  }

  void display() {
    fill(c, map(timer, 0, timer2, 0, 255));;
    stroke(c, map(timer, 0, timer2, 0, 255));
    ellipse(xpos, ypos, 2, 2);
  }

  void move() {
    xpos += xforce;
    ypos += yforce;
    yforce += ygravity;
    timer--;
    if (timer <= 0) {
      for (int i = 0; i < 200; i++) {
        fogos.add(new Fogo(xpos, ypos));
      }
    }
  }
}