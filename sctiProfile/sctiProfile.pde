PImage img;
color grad1 = color(21, 152, 88), grad2 = color(21, 87, 152);

void setup() {
  size(3000, 3000);
  img = loadImage("logo.png");

  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      if (alpha(img.pixels[y * img.width + x]) > 0) {
        float inter = map(x, 0, img.width, 0, 1);
        img.pixels[y * img.width + x] = lerpColor(grad2, grad1, inter);
      }
    }
  }

  //img.resize(3000, 3000);

  PGraphics graph = createGraphics(3000, 3000, JAVA2D);
  graph.smooth(8);
  graph.imageMode(CENTER);
  graph.beginDraw();
  graph.noStroke();
  //graph.fill(77, 171, 207);
  graph.fill(255);
  //graph.background(0);
  graph.ellipse(width / 2, height / 2, width * 0.95, height * 0.95);
  graph.image(img, width / 2, height / 2);
  graph.endDraw();

  graph.save("data/profile.png");

  image(graph, 0, 0);
}

void draw() {
}
