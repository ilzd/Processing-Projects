class Node {
  float px, py;
  float radius;
  color c;

  Node(color c, float radius) {
    this.radius = radius;
    this.c = c;
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(px, py, radius * 2, radius * 2);
  }
}
