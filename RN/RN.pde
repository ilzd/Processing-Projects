NeuralNetwork nets[] = new NeuralNetwork[100];
int trainingCount = 1000, generations = 1000;

void setup() {
  size(500, 500);

  for (int i = 0; i < nets.length; i++) {
    nets[i] = new NeuralNetwork(new int[] {2, 3, 3, 3, 2});
  }

  testNets();
  sortNets();

  for (int i = 0; i < nets.length; i++) {
    print(nets[i].error + " , ");
    nets[i].error = 0;
  }

  for (int i = 0; i < generations; i++) {
    testNets();
    evolveNets();
  }

  testNets();
  sortNets();
  
  println("\n\n");

  for (int i = 0; i < nets.length; i++) {
    print(nets[i].error + " , ");
  }

  ellipse(width / 2, height / 2, 400, 400);
}

void draw() {
}

void mousePressed() {
  println("\n");
  println(nets[0].solve(new float[] {mouseX, mouseY}));
}

void testNets() {
  for (int j = 0; j < nets.length; j++) {
    for (int i = 0; i < trainingCount; i++) {
      float x = random(0, width);
      float y = random(0, height);
      float d = dist(x, y, width / 2, height / 2);
      float[] input = {x, y};
      float[] expected = {(d < 200) ? 1 : 0, (d < 200) ? 0 : 1};
      nets[j].test(input, expected);
    }
  }
}

void evolveNets() {
  sortNets();
  NeuralNetwork[] bestOnes = new NeuralNetwork[10];
  for (int i = 0; i < bestOnes.length; i++) {
    bestOnes[i] = nets[i];
  }
  for (int i = 0; i < bestOnes.length; i++) {
    for (int j = 0; j < 10; j++) {
      nets[i * 10 + j] = bestOnes[i].reproduce();
    }
  }
}

void sortNets() {
  int count = 0;
  NeuralNetwork aux;
  do {
    count = 0;
    for (int i = 0; i < nets.length - 1; i++) {
      if (nets[i].error > nets[i + 1].error) {
        count++;
        aux = nets[i];
        nets[i] = nets[i + 1];
        nets[i + 1] = aux;
      }
    }
  } while (count > 0);
}
