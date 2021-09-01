float lr = 0.001;
float w1 = 0, w2 = 0;
float threshold = 0.1;

void setup() {
  size(500, 500);
  train(10000);
  line(0, 0, width, height);
  println(w1 + " # " + w2);
}

void draw() {
}

void mousePressed() {
  println(test(mouseX, mouseY));
}

int test(float x1, float x2) {
  float sum = x1 * w1 + x2 * w2;
  return (sum >= threshold) ? 1 : 0;
}

void train(int count) {
  float x1, x2, error;
  int expected, result;
  for (int i = 0; i < count; i++) {
    x1 = random(width);
    x2 = random(height);


    expected = (x2 > x1) ? 1 : 0;
    result = test(x1, x2);

    error = expected - result;

    w1 = w1 + error * x1 * lr;
    w2 = w2 + error * x2 * lr;
  }
}
