boolean[][] walls = new boolean[19][19];
float step;

void setup() {
  size(500, 500);
  stroke(0);
  strokeWeight(1);
  step = width / (float)walls.length;
}

void draw() {
  for (int i = 0; i < walls.length; i++) {
    for (int j = 0; j < walls.length; j++) {
      boolean wall = walls[i][j];
      if (!wall) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rect(i * step, j * step, step, step);
    }
  }
}

void mousePressed() {
  int x = (int)(mouseX / step);
  int y = (int)(mouseY / step);
  walls[x][y] = !walls[x][y];

  printMap();
}

void printMap() {
  String map = "[\n";

  for (int i = 0; i < walls.length; i++) {
    map += "[";
    for (int j = 0; j < walls.length; j++) {
      map += walls[i][j];
      if(j < walls.length - 1) map += ",";
    }
    map += "]";
    if(i < walls.length - 1) map += ",\n";
  }

  map += "\n]";
  
  println("\n\n\n" + map);
}
