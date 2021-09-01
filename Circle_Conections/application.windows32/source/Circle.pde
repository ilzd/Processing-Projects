class Circle {
  Node[] nodes;
  float ang, angV, t = random(0, 1), s = random(0, 40), vs = random(0.05, 0.1);
  float radius, auxRadius = 0;
  float px, py;
  color cor;

  Circle(int nodeCount, float radius, float px, float py, color c) {
    this.cor = c;
    this.radius = radius;
    this.px = px;
    this.py = py;
    nodes = new Node[nodeCount];
    for (int i = 0; i < nodes.length; i++) {
      nodes[i] = new Node(c, 3);
    }
  }

  void update() {
    process();
    display();
  }

  void process() {
    t += random(-0.2, 0.2);
    angV = map(noise(t), 0, 1, -0.01, 0.01);
    ang += angV;

    s += vs;
    if (s < 0 || s > 40) vs *= -1;
    auxRadius = map(s, 0, 40, -radius / 10, radius / 10);

    float baseAng;
    for (int i = 0; i < nodes.length; i++) {
      baseAng = map(i, 0, nodes.length - 1, 0, TWO_PI);
      nodes[i].px = px + cos(baseAng + ang) * (radius + auxRadius);
      nodes[i].py = py + sin(baseAng + ang) * (radius + auxRadius);
    }
  }

  void display() {
    for (Node n : nodes) {
      n.display();
    }
    //noFill();
    //stroke(cor);
    //strokeWeight(0.1);
    //ellipse(px, py, radius * 2, radius * 2);
  }

  void displayConnections(Circle c, float min, float max) {
    stroke(cor);
    for (Node n1 : nodes) {
      for (Node n2 : c.nodes) {
        float dist = distSq(n1.px, n1.py, n2.px, n2.py);
        if (dist < max) {
          strokeWeight(map(dist, min, max, 0.1, 0));
          line(n1.px, n1.py, n2.px, n2.py);
        }
      }
    }
  }
}
