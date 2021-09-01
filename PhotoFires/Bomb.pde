class Bomb {
  float x, y, dX, dY;
  int duration, time = 0;

  public Bomb(float x, float y, float dX, float dY, int duration) {
    this.x = x;
    this.y = y;
    this.dX = dX;
    this.dY = dY;
    this.duration = duration;
  }

  public void move() {
    x += dX;
    y += dY;
    dY += 0.03;
    time++;
  }

  public void display() {
    stroke(255, 255, 0, map(time, 0, duration, 255, -50));
    strokeWeight(map(time, 0, duration, 8, 0));
    point(x, y);
  }
}
