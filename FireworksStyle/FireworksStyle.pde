boolean drawing = true;
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Launcher> launchers = new ArrayList<Launcher>();
ArrayList<Fire> fires = new ArrayList<Fire>();

void setup() {
  fullScreen();
  frameRate(60);
  strokeWeight(5);
}

void draw() {
  noStroke();
  fill(0, 50);
  rect(0, 0, width, height);
  if (drawing) {
    if (mousePressed) {
      points.add(new Point(mouseX, mouseY));
    }
    stroke(255);
    for (int i = 0; i < points.size(); i++) {
      point(points.get(i).x, points.get(i).y);
    }
  } else {
    for (int i = 0; i < launchers.size(); i++) {
      launchers.get(i).move();
      launchers.get(i).display();
      if (launchers.get(i).timer < 0) {
        launchers.remove(i);
        println(launchers.size());
      }
    }
    for (int i = 0; i < fires.size(); i++) {
      fires.get(i).move();
      fires.get(i).display();
      if (fires.get(i).timer <= 0) {
        fires.remove(i);
        println(fires.size());
      }
    }
  }
}

void keyPressed() {
  if (drawing) {
    if (points.size() > 0) {
      drawing = false;
      centralize();
    }
  } else {
    drawing = true;
    points.clear();
    launchers.clear();
    fires.clear();
  }
}

void mousePressed() {
  if (!drawing) {
    launchers.add(new Launcher(mouseX, mouseY));
  }
}


void centralize() {
  float xMax = points.get(0).x, xMin = points.get(0).x, yMax = points.get(0).y, yMin = points.get(0).y;
  for (int i = 0; i < points.size(); i++) {
    if (points.get(i).x > xMax) {
      xMax = points.get(i).x;
    } else if (points.get(i).x < xMin) {
      xMin = points.get(i).x;
    }
    if (points.get(i).y > yMax) {
      yMax = points.get(i).y;
    } else if (points.get(i).y < yMin) {
      yMin = points.get(i).y;
    }
  }

  float xMid = (xMin + xMax) / 2;
  float yMid = (yMin + yMax) / 2;
  for (int i = 0; i < points.size(); i++) {
    points.get(i).x -= xMid;
    points.get(i).y -= yMid;
  }
}
