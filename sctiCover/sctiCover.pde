color grad1 = color(21, 152, 88), grad2 = color(21, 87, 152);
PImage logo;

void setup() {
  size(820, 312);
  smooth(8);

  PFont font = createFont("OpenSans-Regular.ttf", 12);
  textFont(font);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  logo = loadImage("logo.png");
  logo.resize(230, 230);
}

void draw() {
}

void drawGradient() {
  strokeWeight(1);
  for (int i = 0; i <= width; i++) {
    float inter = map(i, 0, width, 0, 1);
    color c = lerpColor(grad2, grad1, inter);
    stroke(c);
    line(i, 0, i, height);
  }
}

void paintNodes(int amount) {
  Node[] nodes = new Node[amount];
  for (int i = 0; i < amount; i++) {
    Node node = new Node();

    boolean colliding = true;
    while (colliding) {
      colliding = false;
      for (int j = 0; j < i; j++) {
        if (dist(node.px, node.py, nodes[j].px, nodes[j].py) < (node.radius + nodes[j].radius) + 50) {
          node = new Node();
          colliding = true;
          break;
        }
      }
    }

    nodes[i] = node;
    nodes[i].display();
  }

  for (int i = 0; i < nodes.length - 1; i++) {
    for (int j = i + 1; j < nodes.length; j++) {
      Node n1 = nodes[i], n2 = nodes[j];
      float dist = dist(n1.px, n1.py, n2.px, n2.py);
      if (dist < 200) {
        strokeWeight(map(dist, 0, 200, 2, 0.1));
        PVector dir = new PVector(n2.px - n1.px, n2.py - n1.py).normalize();
        line(n1.px + dir.x * n1.radius, n1.py + dir.y * n1.radius, n2.px - dir.x * n2.radius, n2.py - dir.y * n2.radius);
      }
    }
  }
}

void mousePressed() {
  drawGradient();


  paintNodes(150);

  //textSize(230);
  //fill(0, 0, 0, 30);
  //text("2019", width / 2, height / 4.3);

  image(logo, width / 2, height / 2.7);

  textSize(18);
  fill(255);
  text("9ª Semana de Ciência da Computação e Tecnologia da Informação", width / 2, height / 1.4);
  text("04 a 09 de Novembro", width / 2, height / 1.4 + 29);
  text("Centro de Convenções da UENF", width / 2, height / 1.4 + 58);

  int i = 0;
  while (true) {
    i++;
    File f = dataFile("cover" + i + ".png");
    if (!f.isFile()) {
      saveFrame("data/cover" + i + ".png");
      break;
    }
  }
}
