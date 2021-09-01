ArrayList<Queen> queens = new ArrayList();
Queen queen = new Queen();

int boardSize = 1;
boolean running = false;

void setup() {
  size(500, 500);
  textSize(20);
  stroke(255);
  frameRate(60);
}

void draw() {
  background(0);
  drawGrid();
  if (!running) {
    frameRate(60);
    boardSize = constrain((int)map(mouseX, 0, width - 50, 4, 12), 4, 12);
  } else {
    frameRate(map(mouseY, 0, height, 1, map(boardSize, 4, 12, 20, 400)));
    solveProblem();
    drawQueens();
  }
  println(boardSize);
}

int modulo(int x) {
  if (x >= 0) {
    return x;
  } else {
    return -x;
  }
}

void mousePressed() {
  if (running) {
    queens.clear();
    queen.x = 1;
    queen.y = 1;
    running = false;
  } else {
    running = true;
  }
}

void solveProblem() {
  if (queen.y <= boardSize) {
    boolean isGuarded = false;
    for (int i = 0; i < queens.size(); i++) {
      if (queens.get(i).guards(queen.x, queen.y)) {
        isGuarded = true;
        break;
      }
    }
    if (!isGuarded) {
      Queen newQueen = new Queen();
      newQueen.x = queen.x;
      newQueen.y = queen.y;
      queens.add(newQueen);
      queen.y++;
      queen.x = 1;
    } else {
      queen.x++;
      if (queen.x > boardSize) {
        while (queen.x > boardSize) {
          queen.x = queens.get(queens.size() - 1).x;
          queen.x++;
          queen.y = queens.get(queens.size() - 1).y;
          queens.remove(queens.size() - 1);
        }
      }
    }
  }
}

void drawGrid() {
  float size = width / boardSize;
  stroke(255, 0, 0);
  strokeWeight(50 / boardSize);
  for (int i = 0; i < boardSize; i++) {
    line(size * (i + 1), 0, size * (i + 1), height);
    line(0, size * (i + 1), width, size * (i + 1));
  }
}

void drawQueens() {
  float size = width / boardSize;
  strokeWeight(5);
  for (int i = 0; i < queens.size(); i++) {
    stroke(0, 255, 0);
    fill(0, 255, 0);
    ellipse((queens.get(i).x - 1) * size + size / 2, (queens.get(i).y - 1) * size + size / 2, 120 / boardSize, 120 / boardSize);
  }
  stroke(255);
  fill(255);
  ellipse((queen.x - 1) * size + size / 2, (queen.y - 1) * size + size / 2, 40 / boardSize, 40 / boardSize);
}