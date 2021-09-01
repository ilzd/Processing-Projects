PImage pic1, pic2, pic3;

void setup() {
  size(1795, 1204);
  smooth(8);
  pic1 = loadImage("1.jpg");
  pic1.resize(int(pic1.width * 0.55), int(pic1.height * 0.55));

  pic2 = loadImage("2.jpg");
  pic2 = pic2.get(0, 0, pic2.width - 300, pic2.height);
  pic2.resize(int(pic2.width * 0.54), int(pic2.height * 0.54));


  pic3 = loadImage("3.jpg");
  pic3 = pic3.get(0, 900, pic3.width - 50, pic3.height);
  pic3.resize(int(pic3.width * 0.77), int(pic3.height * 0.77));

  image(pic1, -110 + 2 * (width / 3), -150);
  image(pic2, 0, 0);
  image(pic3, -50,  height / 2);

  PFont font = createFont("font5.ttf", 32);
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(170);
  String message = "I LOVE YOU";

  fill(255);
  text(message, 4 + width / 2, 4 + height / 2);

  fill(0);
  text(message, -4 + width / 2, -4 + height / 2);


  fill(255, 50, 50);
  text(message, width / 2, height / 2);

  //PImage result = get(0, 0, width, height);
  //result.resize(1795, 1204);
  
  //result.save("foto.jpg");
  save("foto.jpg");
}

void draw() {
}
