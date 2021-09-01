class Agnesi {
  float x, y, w, h, radius;
  Point center, O, M;
  int i = 0;

  ArrayList<Point> As = new ArrayList();
  ArrayList<Point> Ns = new ArrayList();
  ArrayList<Point> Ps = new ArrayList();

  Agnesi(float x, float y, float w, float h, float radius) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.radius = radius;
    center = new Point(x, y - radius);
    O = new Point(x, y);
    M = new Point(x, y - radius * 2);

    compute();
  }

  void compute() {
    float ang = 0;
    while (ang <= TWO_PI) {
      Point A = new Point(center.x + cos(-ang + PI / 2) * radius, center.y + sin(-ang + PI / 2) * radius);
      As.add(A);

      float prop = (M.y - O.y) / (A.y - O.y);

      Point N = new Point((A.x - O.x) * prop + x, (A.y - O.y) * prop + y);
      Ns.add(N);

      Point P = new Point(N.x, A.y);
      Ps.add(P);

      ang += 0.003;
    }
  }

  void display() {

    fill(255, 255, 0, 50);
    noStroke();
    beginShape();
    for (int j = 0; j < Ps.size(); j++) {
      vertex(Ps.get(j).x, Ps.get(j).y);
    }
    endShape(CLOSE);

    Point A = As.get(i);
    Point N = Ns.get(i);
    Point P = Ps.get(i);

    strokeWeight(1);
    stroke(0);
    //Plano
    line(x - w / 2, y, x + w / 2, y);
    line(x, y - h / 2, x, y + h / 2);

    fill(60, 10);
    strokeWeight(0.5);
    ellipse(center.x, center.y, radius * 2, radius * 2);
    line(O.x, O.y, A.x, A.y);
    line(M.x, M.y, N.x, N.y);
    triangle(A.x, A.y, N.x, N.y, P.x, P.y);

    stroke(255, 0, 0);
    strokeWeight(4);
    point(O.x, O.y);
    point(M.x, M.y);
    point(A.x, A.y);
    point(N.x, N.y);

    stroke(0, 0, 255);
    strokeWeight(10);
    point(P.x, P.y);

    i++;
    if (i == Ps.size()) {
      i = 0;
    }
  }
}
