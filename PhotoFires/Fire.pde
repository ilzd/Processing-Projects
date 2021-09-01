class Fire {
  float x, y, dX, dY;
  int duration, size, time;
  color c;

  public Fire(float x, float y, float dX, float dY, int duration, color c, int size) {
    this.x = x;
    this.y = y;
    this.dX = dX;
    this.dY = dY;
    this.duration = duration;
    this.c = c;
    this.size = size;
  }

  public void move() {
    if (time < duration) {
      x += dX;
      y += dY;
      time++;
    }
  }

  public void display() {
    stroke(c);
    strokeWeight(size * 1.55);
    point(x, y);
  }
}
