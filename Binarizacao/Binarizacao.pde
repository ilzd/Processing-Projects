PImage originalImage, grayImage, contrastGrayImage, preImage, binaryImage;
final float INF = 999999999;
int xi, yi, xf, yf;
float[][] mask = {
  {1/9f, 1/9f, 1/9f}, 
  {1/9f, 1/9f, 1/9f}, 
  {1/9f, 1/9f, 1/9f}   
};

void setup() {
  fullScreen();
  rectMode(CORNERS);

  originalImage = loadImage("assinatura.jpeg");
  originalImage.resize(500, height * (500 / originalImage.width));

  updateImages();
}

void draw() {
  if (mousePressed) {
    int mx = constrain(mouseX, 2, originalImage.width - 2);
    int my = constrain(mouseY, 2, originalImage.height - 2);

    int index;
    originalImage.loadPixels();
    for (int i = mx - 2; i < mx + 2; i++) {
      for (int y = my - 2; y < my + 2; y++) {
        index = y * originalImage.width + i;
        originalImage.pixels[index] = color(255, 0, 0);
      }
    }
    originalImage.updatePixels();

    updateImages();
  }
}

void updateImages() {
  background(127);
  grayImage = imageToGray(originalImage);

  //Media
  //preImage = applyMask(originalImage);

  //Gaussiano
  preImage = grayImage.copy();
  preImage.filter(BLUR, 1);

  binaryImage = grayToBinary(preImage);
  image(preImage, 0, preImage.height);
  image(originalImage, 0, 0);
  image(binaryImage, originalImage.width, 0);

  stroke(255, 0, 0);
  strokeWeight(2);
  noFill();
  findPOI(binaryImage);
  translate(originalImage.width, 0);
  rect(xi, yi, xf, yf);
}

void keyPressed() {
  //if (keyCode == BACKSPACE) {
  originalImage.loadPixels();
  for (int i = 0; i < originalImage.pixels.length; i++) {
    originalImage.pixels[i] = color(255);
  }
  originalImage.updatePixels();
  updateImages();
  //}
}
