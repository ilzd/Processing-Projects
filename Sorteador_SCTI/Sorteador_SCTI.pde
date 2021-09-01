boolean drawing = true;
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Launcher> launchers = new ArrayList<Launcher>();
ArrayList<Fire> fires = new ArrayList<Fire>();
int maxValue = 50;

void setup() {
  fullScreen();
  frameRate(60);
  strokeWeight(5);
}

void draw() {
  noStroke();
  fill(0, 50);
  rect(0, 0, width, height);

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
      //println(fires.size());
    }
  }

  textSize(50);
  fill(255);
  text("VALOR MÁXIMO " + maxValue, 20, height - 20);
}

void keyPressed() {
  if (key == ' ') {
    points.clear();
    getPoints();
    centralize();
    launchers.add(new Launcher(width / 2, height));
  } else if (key == '-') {
    if (maxValue > 1) maxValue--;
  } else if (key == '+') {
    maxValue++;
  }
}

void mousePressed() {
  //if (!drawing) {
  //  launchers.add(new Launcher(mouseX, mouseY));
  //}
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

void getPoints() {
  background(0);
  textSize(400);
  int num = 1 + (int) (random(1) * maxValue);
  println(num);
  fill(0, 0, 1); 
  text(num, 600, 400);
  PImage frame = get(0, 0, width, height);
  for (int i = 0; i < frame.width; i+= 5) {
    for (int j = 0; j < frame.height; j += 5) {
      color c = frame.pixels[j * frame.width + i];
      if (red(c) != 0 || green(c) != 0 || blue(c) != 0) {
        points.add(new Point(i, j));
      }
    }
  }
}
