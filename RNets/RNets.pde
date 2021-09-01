Ball[] balls = new Ball[50];
Enemy[] enemies = new Enemy[10];

int aux, generation = 1, average = 0, best = 0, bestNet = 0;
boolean fast = true, training = true;

void setup() {  
  size(600, 600);
  frameRate(9999);
  strokeWeight(0.1);
  stroke(255);
  textSize(24);
  noSmooth();
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
  for (int i = 0; i < enemies.length; i++) {
    enemies[i] = new Enemy();
  }
}

void draw() {
  background(0);
  if (training) {
    trainNets();
  } else {
    demonstrateNet();
  }
}

void demonstrateNet() {
  balls[0].update();
  balls[0].display();

  for (int i = 0; i < enemies.length; i++) {
    enemies[i].move();
    enemies[i].display();
  }

  if (balls[0].dead) {
    reset();
  }
}

void advance(int amount) {
  while (amount >= generation) {
    trainNets();
  }
}

void trainNets() {
  aux = 0;
  for (int i = 0; i < balls.length; i++) {
    if (!balls[i].dead) {
      aux++;
      balls[i].update();
      balls[i].display();
    }
  }
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].move();
    enemies[i].display();
  }

  text("Generation: " + generation, 0, 24);
  text("Average: " + average, 0, 48);
  text("Best: " + best, 0, 72);
  text("Best Net: " + bestNet, 0, 96);

  if (aux == 0) {
    generation++;
    sortBalls();

    average = 0;
    for (Ball b : balls) {
      average += b.surviveTime;
    }
    average /= balls.length;
    if (average > best) { 
      best = average;
    }

    if (balls[0].surviveTime > bestNet) bestNet = balls[0].surviveTime;

    reset();

    for (int i = 0; i < balls.length / 2; i++) {
      balls[(balls.length / 2) * 1 + i].net = new Net(balls[i].net);
      balls[(balls.length / 2) * 1 + i].net.mutate();
      //balls[(balls.length / 5) * 2 + i].net = new Net(balls[i].net);
      //balls[(balls.length / 5) * 2 + i].net.mutate();
      //balls[(balls.length / 5) * 3 + i].net = new Net(balls[i].net);
      //balls[(balls.length / 5) * 3 + i].net.mutate();
      //balls[(balls.length / 5) * 4 + i].net = new Net(balls[i].net);
      //balls[(balls.length / 5) * 4 + i].net.mutate();
    }
  }
}

void reset() {
  for (int i = 0; i < balls.length; i++) {
    balls[i].reset();
  }
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].reset();
  }
}

void keyPressed() {
  if (key == 'f') {
    if (!fast) {
      fast = true;
      frameRate(9999);
    } else {
      fast = false;
      frameRate(30);
    }
  } else if (key == 't') {
    if (training) {
      sortBalls();
    } else {
      reset();
    }
    training = !training;
  } else if (key == '1') {
    advance(generation + 1);
  } else if (key == '2') {
    advance(generation + 5);
  } else if (key == '3') {
    advance(generation + 10);
  } else if (key == '4') {
    advance(generation + 50);
  } else if (key == '5') {
    advance(generation + 100);
  }
}

void sortBalls() {
  int count = 1;
  Ball aux;
  while (count > 0) {
    count = 0;
    for (int i = 0; i < balls.length - 1; i++) {
      if (balls[i].surviveTime < balls[i + 1].surviveTime) {
        aux = balls[i];
        balls[i] = balls[i + 1];
        balls[i + 1] = aux;
        count++;
      }
    }
  }
}
