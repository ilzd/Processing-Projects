class OrbitEffect {
  TextPhys[] textP;
  int values[] = {1, 2, 3, 4, 5, 6, -1, -2, -3, -4, -5, -6};
  float ang = 1, speed;

  public OrbitEffect(String text) {
    int textLength = text.length();
    float middlePosition = (float)textLength / 2;

    this.textP = new TextPhys[textLength];
    for (int i = 0; i < textLength; i++) {
      textP[i] = new TextPhys(text.charAt(i), i * 32 - (middlePosition * 32), 0, 400, values[(int)random(0, values.length)], values[(int)random(0, values.length)]);
    }
  }

  void display() {
    speed = map(distToPower(ang, TWO_PI, 1), 6, 0, 0.025, 0.0002);
    translate(width / 2, height / 2);

    fill(10, 0, 0, 35);
    noStroke();
    translate(0, 0, -400);
    rect(-width, -height, width * 2, height * 2);
    translate(0, 0, 400);

    fill(150, 50, 50);
    textSize(32);
    strokeWeight(1);
    stroke(255, 0, 0);

    for (int i = 0; i < textP.length; i++) {
      rotateX(textP[i].angX * ang);
      rotateY(textP[i].angY * ang);
      translate(0, 0, textP[i].z);
      text(textP[i].c, textP[i].x, textP[i].y);
      translate(0, 0, -textP[i].z);
      rotateY(-textP[i].angY * ang);
      rotateX(-textP[i].angX * ang);
    }

    ang += speed;

    if (ang >= TWO_PI * 2) ang = 0;
  }
}

class TextPhys {
  float x, y, z; 
  int angX, angY;
  char c;

  public TextPhys(char c, float x, float y, float z, int angX, int angY) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.angX = angX;
    this.angY = angY;
    this.c = c;
  }
}

float distToPower(float x1, float x2, float power) {
  return pow(sqrt(pow(x1 - x2, 2)), power);
}

float dist1D(float x1, float x2) {
  return sqrt(pow(x2 - x1, 2));
}
