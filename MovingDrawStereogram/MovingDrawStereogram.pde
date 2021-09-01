ArrayList<Drawing> drawings = new ArrayList<Drawing>();
ArrayList<float[]> positions = new ArrayList<float[]>();
float x0, y0, x, y;
boolean clicking;
PImage aux1, aux2, stereogram;


void setup() {
  background(0);
  noCursor();
  size(800, 600);
  aux1 = createImage(width, height, RGB);
  aux2 = createImage(width, height, RGB);
}

void draw() {
  background(0);
  if (mousePressed) {
    if (!clicking) {
      clicking = true;
      x = mouseX;
      y = mouseY;
    }
  } else {
    if (clicking) {
      clicking = false;
    }
  }
  if (clicking) {
    if (x != mouseX || y != mouseY) {
      float[] pos = new float[4];
      pos[0] = mouseX;
      pos[1] = mouseY;
      pos[2] = (pos[0] - x);
      pos[3] = (pos[1] - y);
      positions.add(pos);
      x = pos[0];
      y = pos[1];
    }
  }

  colorMode(RGB, 255);
  stroke(255);
  fill(255);
  strokeWeight(1);
  ellipse(mouseX, mouseY, 50, 50);

  strokeWeight(30);
  for (int i = 0; i < positions.size() - 1; i++) {
    line(positions.get(i)[0], positions.get(i)[1], positions.get(i + 1)[0], positions.get(i + 1)[1]);
  }

  for (int i = 0; i < drawings.size(); i++) {
    Drawing dr = drawings.get(i);
    dr.move();
    dr.display();
  }

  aux1 = get(0, 0, width, height);

  for (int i = 0; i < aux1.pixels.length; i++) {
    aux2.pixels[i] = (int)brightness(aux1.pixels[i]);
  }

  float[][] depthLevels = getDepthMapFromImage(aux1);
  int[][] constraints = getConstraintsFromDepthLevels(depthLevels);
  stereogram = getAutostereogramFromConstraints(constraints);
  image(stereogram, 0, 0);
}

void mouseReleased() {
  if (positions.size() > 0) {
    drawings.add(new Drawing(positions)); 
    positions.clear();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    drawings.clear();
  }
}
