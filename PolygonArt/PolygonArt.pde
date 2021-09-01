float[][] blurMatrix = {
  {1, 1, 1}, 
  {1, 1, 1}, 
  {1, 1, 1}  
};

PShape teste;
Polygon[] p = new Polygon[3];

void setup() {
  fullScreen();
  frameRate(9999);
  for (int i = 0; i < p.length; i++) {
    p[i] = new Polygon(2, 500);
  }

  background(0);

  //for (int j = 0; j < 10000; j++) {
  //  if (j % 1000 == 0) {
  //    PImage frame = get(0, 0, width, height);
  //    frame = applyBlur(frame);
  //    image(frame, 0, 0);
  //  }
  //  for (int i = 0; i < p.length; i++) {
  //    p[i].move();
  //    p[i].display();
  //  }
  //}

  //saveFrame("data/" + random(0, 9999999) + ".png");
}

void draw() {
  //background(0);
  for (int i = 0; i < p.length; i++) {
    p[i].move();
    p[i].display();
  }
}

void keyPressed() {
  //saveFrame("data/frame###.png");
}

PImage applyBlur(PImage image) {
  PImage bluredImage = createImage(image.width, image.height, RGB);
  int matrixRange = blurMatrix.length / 2;
  float totalWeight = 0;

  for (int i = 0; i < blurMatrix.length; i++) {
    for (int j = 0; j < blurMatrix[i].length; j++) {
      totalWeight += blurMatrix[i][j];
    }
  }

  int index;
  float[] bluredPixel = new float[3];
  bluredImage.loadPixels();
  for (int x = 0; x < bluredImage.width; x++) {
    for (int y = 0; y < bluredImage.height; y++) {
      bluredPixel[0] = 0; 
      bluredPixel[1] = 0; 
      bluredPixel[2] = 0;
      for (int i = 0; i < blurMatrix.length; i++) {
        for (int j = 0; j < blurMatrix[i].length; j++) {
          index = constrain(y + j - matrixRange, 0, bluredImage.height - 1) * bluredImage.width + constrain(x + i - matrixRange, 0, bluredImage.width - 1);
          bluredPixel[0] += red(image.pixels[index]) * blurMatrix[i][j]; 
          bluredPixel[1] += green(image.pixels[index]) * blurMatrix[i][j]; 
          bluredPixel[2] += blue(image.pixels[index]) * blurMatrix[i][j];
        }
      }
      bluredPixel[0] /= totalWeight;
      bluredPixel[1] /= totalWeight;
      bluredPixel[2] /= totalWeight;
      bluredImage.pixels[y * bluredImage.width + x] = color(bluredPixel[0], bluredPixel[1], bluredPixel[2]);
    }
  }
  bluredImage.updatePixels();
  return bluredImage;
}
