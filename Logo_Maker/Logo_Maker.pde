int weight = 5;
int dia1 = 400, dia2 = 350, dia3 = 300;
float screenProp;
PGraphics logo;

void setup() {
  size(3000, 3000);
  screenProp = width / 500;
}

void draw() {
}

void mousePressed() {
  background(0);

  logo = createGraphics(width, height, JAVA2D);
  logo.smooth(8);
  logo.beginDraw();
  logo.strokeCap(PROJECT);
  logo.fill(255, 0);
  logo.noStroke();
  logo.rect(0, 0, width, height);

  logo.stroke(255);
  logo.noFill();
  logo.strokeWeight(weight * screenProp);

  float ang = random(0, TWO_PI);
  float angularSize = radians(280);
  
  //arc(width / 2, height / 2, dia1, dia1, ang, ang + random(PI, TWO_PI - PI / 3));
  logo.arc(width / 2, height / 2, dia1 * screenProp, dia1 * screenProp, ang, ang + angularSize);

  ang = random(0, TWO_PI);
  //arc(width / 2, height / 2, dia2, dia2, ang, ang + random(PI, TWO_PI - PI / 3));
  logo.arc(width / 2, height / 2, dia2 * screenProp, dia2 * screenProp, ang, ang + angularSize);

  ang = random(0, TWO_PI);
  //arc(width / 2, height / 2, dia3, dia3, ang, ang + random(PI, TWO_PI - PI / 3));
  logo.arc(width / 2, height / 2, dia3 * screenProp, dia3 * screenProp, ang, ang + angularSize);
  logo.endDraw();

  int i = 0;
  while (true) {
    i++;
    File f = dataFile("logo" + i + ".png");
    if (!f.isFile()) {
      logo.save("data/logo" + i + ".png");
      break;
    }
  }

  background(0);
  image(logo, 0, 0, 500, 500);
}
