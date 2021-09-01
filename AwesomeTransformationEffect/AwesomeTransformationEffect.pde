ArrayList<float[]> pos1 = new ArrayList<float[]>(), pos2 = new ArrayList<float[]>(), posAux = new ArrayList<float[]>();
boolean drawing1 = true, drawing2, changing;
float biggestDist;

void setup() {
  size(700, 500);
  strokeWeight(15);
  textSize(32);
}

void draw() {
  background(0);
  println(frameRate);
  if (drawing1 && mousePressed) {
    float p[] = new float[2], p2[] = new float[2];
    p[0] = mouseX;
    p[1] = mouseY;
    p2[0] = p[0];
    p2[1] = p[1];
    pos1.add(p);
    posAux.add(p2);
  }
  if (drawing2 && mousePressed) {
    float p[] = {mouseX, mouseY};
    pos2.add(p);
  }

  if (drawing2) {
    stroke(0, 255, 0);
    text("DESENHO 2", 0, height);
    for (int i = 0; i < pos2.size() - 1; i++) {
      //line(pos2.get(i)[0], pos2.get(i)[1], pos2.get(i + 1)[0], pos2.get(i + 1)[1]);
      point(pos2.get(i)[0], pos2.get(i)[1]);
    }
  }

  if (changing) {
    stroke(255);
    for (int i = 0; i < pos1.size() - 1; i++) {
      //line(pos1.get(i)[0], pos1.get(i)[1], pos1.get(i + 1)[0], pos1.get(i + 1)[1]);
      point(pos1.get(i)[0], pos1.get(i)[1]);
    }
  } else if (drawing1) {
    stroke(255, 0, 0);
    text("DESENHO 1", 0, height);
    for (int i = 0; i < pos1.size() - 1; i++) {
      //line(pos1.get(i)[0], pos1.get(i)[1], pos1.get(i + 1)[0], pos1.get(i + 1)[1]);
      point(pos1.get(i)[0], pos1.get(i)[1]);
    }
  }

  if (changing) {
    boolean stillDiff = false;
    for (int i = 0; i < pos1.size(); i++) {
      PVector v = new PVector(pos2.get((int)map(i, 0, pos1.size() - 1, 0, pos2.size() - 1))[0] - pos1.get(i)[0], pos2.get((int)map(i, 0, pos1.size() - 1, 0, pos2.size() - 1))[1] - pos1.get(i)[1]);
      PVector v2 = new PVector(pos2.get((int)map(i, 0, posAux.size() - 1, 0, pos2.size() - 1))[0] - posAux.get(i)[0], pos2.get((int)map(i, 0, posAux.size() - 1, 0, pos2.size() - 1))[1] - posAux.get(i)[1]);

      if (sqrt(pow(v.x, 2)) > 0.71 || sqrt(pow(v.y, 2)) > 0.71) {
        v2.div(biggestDist).mult(1.5);
        pos1.get(i)[0] += v2.x;  
        pos1.get(i)[1] += v2.y;
        stillDiff = true;
      }
    }
    if (!stillDiff) {
      pos1.clear();
      for (int i = 0; i < pos2.size(); i++) {
        float p[] = {pos2.get(i)[0], pos2.get(i)[1]};
        pos1.add(p);
      }
      pos2.clear();
      for (int i = 0; i < posAux.size(); i++) {
        float p[] = {posAux.get(i)[0], posAux.get(i)[1]};
        pos2.add(p);
      }
      posAux.clear();
      for (int i = 0; i < pos1.size(); i++) {
        float p[] = {pos1.get(i)[0], pos1.get(i)[1]};
        posAux.add(p);
      }
      getBiggestDist();
    }
  }
}

void keyPressed() {
  if (!drawing1 && !drawing2) {
    pos1.clear();
    pos2.clear();
    posAux.clear();
    changing = false;
    drawing1 = true;
  } else if ((drawing1 && !drawing2 && pos1.size() > 0)) {
    drawing1 = false;
    drawing2 = true;
  } else if (pos2.size() > 0) {
    drawing1 = false;
    drawing2 = false;
    getBiggestDist();
    changing = true;
  }
}

void getBiggestDist() {
  biggestDist = 0;
  for (int i = 0; i < pos1.size(); i++) {
    float dist = new PVector(pos2.get((int)map(i, 0, pos1.size() - 1, 0, pos2.size() - 1))[0] - pos1.get(i)[0], pos2.get((int)map(i, 0, pos1.size() - 1, 0, pos2.size() - 1))[1] - pos1.get(i)[1]).mag();
    if (dist > biggestDist) {
      biggestDist = dist;
    }
  }
}