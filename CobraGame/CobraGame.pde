Game game = new Game();
int moveTimer = 0;

void setup() {
  size(500, 500);
  frameRate(300);
}

void draw() {
  moveTimer++;
  if (moveTimer >= 300 / game.moveSpeed) {
    moveTimer = 0;
    game.move();
    game.display();
  }
}

void keyPressed() {
  println("asd");
  if (keyCode == LEFT && (game.xs != 1 || game.positions.size() == 0)) {
    game.xs = -1;
    game.ys = 0;
  } else if (keyCode == RIGHT && (game.xs != -1 || game.positions.size() == 0))  {
    game.xs = 1;
    game.ys = 0;
  } else if (keyCode == UP && (game.ys != 1 || game.positions.size() == 0))  {
    game.xs = 0;
    game.ys = -1;
  } else if (keyCode == DOWN && (game.ys != -1 || game.positions.size() == 0))  {
    game.xs = 0;
    game.ys = 1;
  }
  game.move();
  game.display();
  moveTimer = 0;
}