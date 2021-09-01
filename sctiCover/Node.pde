class Node {
  float px = random(-width, width * 2);
  float py = random(-height, height * 2);
  float radius = random(5, 10);
  float weight = random(1, 2);

  void display() {
    strokeWeight(weight);
    stroke(255, 255, 255, 20);
    noFill();
    ellipse(px, py, radius * 2, radius * 2);
  }
}
