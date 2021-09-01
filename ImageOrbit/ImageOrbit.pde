PImage image;
AlignEffect alignEffect;

void setup() {
  fullScreen(P3D);
  frameRate(999);
  image = loadImage("img2.jpg");

  float prop = min((float)width / image.width, (float)height / image.height);
  image.resize((int)(image.width * prop), (int)(image.height * prop));

  alignEffect = new AlignEffect(image, 1, 20);
}

void draw() {
  alignEffect.update();
}

float distToPower(float x1, float x2, float power) {
  return pow(sqrt(pow(x1 - x2, 2)), power);
}
