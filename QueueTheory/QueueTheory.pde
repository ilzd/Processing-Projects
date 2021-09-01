Queue queue = new Queue(3, 0.25, 10);

void setup() {
  fullScreen();
  textAlign(RIGHT);
  frameRate(15);
}

void draw() {
  queue.display();
}

void keyPressed() {
  int step = 0;

  switch(key) {
  case '1':
    step = 1;
    break;
  case '2':
    step = 10;
    break;
  case '3':
    step = 100;
    break;
  case '4':
    step = 1000;
    break;
  case '5':
    step = 10000;
    break;
  case 'a':
    queue.chance = min(1, queue.chance + 0.01);
    break;
  case 's':
    queue.chance = max(0, queue.chance - 0.01);
    break;
  case 'z':
    queue.serveTime++;
    break;
  case 'x':
    queue.serveTime = max(1, queue.serveTime - 1);
    break;
  case 'q':
    if (queue.servers.size() < 15)
      queue.addServer();
    break;
  case 'w':
    if (queue.servers.size() > 1) {
      queue.servers.remove(0);
    }
    break;
  case 'g':
    queue.drawingQueue = !queue.drawingQueue;
    break;
  case ' ':
    queue = new Queue(queue.servers.size(), queue.chance, queue.serveTime);
    break;
  default:
    break;
  }

  for (int i = 0; i < step; i++) {
    queue.update();
  }

  queue.atualiza();
}

int fat(int n) {
  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}
