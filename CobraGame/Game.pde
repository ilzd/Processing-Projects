class Game {
  ArrayList<Integer[]> positions= new ArrayList<Integer[]>();
  int gameSize = 20;
  int moveSpeed = 30;
  int xpos = (int) random(1, gameSize + 1);
  int ypos = (int) random(1, gameSize + 1);
  int xs = 0;
  int ys = 0;
  int px = (int) random(1, gameSize + 1);
  int py = (int) random(1, gameSize + 1);
  int pontuation = 0;

  void move() {
    for (int i = positions.size() - 1; i > 0; i--) {
      positions.get(i)[0] =  positions.get(i - 1)[0];
      positions.get(i)[1] =  positions.get(i - 1)[1];
    }
    if (positions.size() > 0) {
      positions.get(0)[0] = xpos;
      positions.get(0)[1] = ypos;
    }

    xpos += xs;
    ypos += ys;

    if (positions.size() > 0) {
      for (int i = 0; i < positions.size(); i++) {
        if (xpos == positions.get(i)[0] && ypos == positions.get(i)[1]) {
          positions.clear();
          xpos = (int) random(1, gameSize + 1);
          ypos = (int) random(1, gameSize + 1);
          px = (int) random(1, gameSize + 1);
          py = (int) random(1, gameSize + 1);
          pontuation = 0;
        }
      }
    }

    if (xpos > gameSize) {
      xpos = 1;
    }
    if (xpos < 1) {
      xpos = gameSize;
    }
    if (ypos > gameSize) {
      ypos = 1;
    }
    if (ypos < 1) {
      ypos = gameSize;
    }
    if (xpos == px && ypos == py) {
      px = (int) random(1, gameSize + 1);
      py = (int) random(1, gameSize + 1);
      Integer[] pos = {xpos, ypos};
      positions.add(pos);
      pontuation++;
    }
  }

  void display() {
    background(50);
    noStroke();
    fill(0, 255, 0);
    rect((xpos - 1) * (width / gameSize), (ypos - 1) * (height / gameSize), height / gameSize, height / gameSize);
    fill(100, 200, 100);
    if (positions.size() > 0) {
      for (int i = 0; i < positions.size(); i++) {
        rect((positions.get(i)[0] - 1) * (width / gameSize), (positions.get(i)[1] - 1) * (height / gameSize), height / gameSize, height / gameSize);
      }
    }
    fill(255, 0, 0);
    rect((px - 1) * (width / gameSize), (py - 1) * (height / gameSize), height / gameSize, height / gameSize);
    stroke(255);
    strokeWeight(3);
    for (int i = 0; i <= gameSize; i++) {
      line(0, (height / gameSize) * i, width, (height / gameSize) * i);
      line((width / gameSize) * i, 0, (width / gameSize) * i, height);
    }
    stroke(0, 0, 255);
    textSize(50);
    text(pontuation, 5, 50);
  }
}