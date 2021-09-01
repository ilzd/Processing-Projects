class Ray {
  ArrayList<float[]> vertexes = new ArrayList<float[]>();
  float x, y;
  float w;
  int childs = 0;

  public Ray(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;
  }

  void Grow() {
    vertexes.clear();
    float x2 = x, y2 = y;
    vertexes.add(new float[2]);
    vertexes.get(0)[0] = x2;
    vertexes.get(0)[1] = y2;
    while (y2 < height) {
      x2 += random(-40, 40);
      y2 += random(25, 35);
      vertexes.add(new float[2]);
      vertexes.get(vertexes.size() - 1)[0] = x2;
      vertexes.get(vertexes.size() - 1)[1] = y2;
      if (random(0, 1) < 0.2 && childs < 2) {
        rays.add(new Ray(x2, y2, w * 0.2));
        rays.get(rays.size() - 1).Grow();
        childs++;
      }
    }
  }

  void Display() {
    strokeWeight(w);
    stroke(255);
    for (int i = 0; i < vertexes.size() - 1; i++) {
      line(vertexes.get(i)[0], vertexes.get(i)[1], vertexes.get(i + 1)[0], vertexes.get(i + 1)[1]);
    }
  }
}