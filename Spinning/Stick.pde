class Stick {
  static final int MAX_GENERATION = 1000;
  PVector pos;
  float ang = random(0, TWO_PI), angSpd = random(-0.007, 0.007), size = random(15, 35);
  Stick child = null;
  int generation;

  Stick(float px, float py, int generation) {
    pos = new PVector(px, py);
    this.generation = generation;

    if (generation < MAX_GENERATION) {
      child = new Stick(0, 0, generation + 1);
    }
  }


  void display() {
    stroke(map(noise(frameCount / 300f), 0, 1, 0, 255), map(noise(frameCount / 200f), 0, 1, 0, 255), map(noise(frameCount / 150f), 0, 1, 0, 255), 255);
    
    //stroke(255);
    line(pos.x, pos.y, pos.x + size * cos(ang), pos.y + size * sin(ang));
    //point(pos.x + size * cos(ang), pos.y + size * sin(ang));
  }

  void move() {
    ang += angSpd;
  }

  void update() {
    move();
    display();

    if (generation < MAX_GENERATION) {
      translate(pos.x + size * cos(ang), pos.y + size * sin(ang));
      child.update();
    }
  }
}
