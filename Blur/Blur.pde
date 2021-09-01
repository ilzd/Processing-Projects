float[][] blurMatrix = {
  {1/9f, 1/9f, 1/9f}, 
  {1/9f, 1/9f, 1/9f}, 
  {1/9f, 1/9f, 1/9f}  
};

PImage image;

void setup() {
  fullScreen();

  image = loadImage("city.jpg");
  image(image, 0, 0);
}

void draw() {
}

void mousePressed(){
  image = applyBlur(image);
  image(image, image.width, 0);
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
