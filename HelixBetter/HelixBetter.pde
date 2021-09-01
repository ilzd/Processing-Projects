ArrayList<Helix> helix = new ArrayList();
int amount = 100;

void setup() {
  fullScreen();
  frameRate(9999);
  background(0);

  for (int i = 0; i < amount; i++) {
    Helix h = new Helix();
    h.setPosition(width / 2, height / 2, random(0, TWO_PI));
    //h.setSpeed(random(-1, 1), random(-1, 1), random(-0.03, 0.03));
    h.setSpeed(0, 0, random(-0.0051546, 0.00051685));
    h.setRadius(random(40, 60));
    h.setStyle(color(random(0, 255), random(0, 255), random(0, 255), 5), 0.1);
    if (i > 0) h.setParent(helix.get(i - 1));
    helix.add(h);
  }
}

void draw() {
  //background(0);
  for (int i = 0; i < helix.size(); i++) {
    helix.get(i).update();
  }
}
