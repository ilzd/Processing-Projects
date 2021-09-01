PImage imagem, gray;
int[] histogram;

void setup() {
  fullScreen();

  imagem = loadImage("img1.jpg");

  gray = RGBtoGray(imagem);
  histogram = getHistogram(gray);
  drawAll();
}

void drawAll() {
  background(0);
  image(gray, 0, 0, gray.width * 0.75, gray.height * 0.75);
  drawHistogram(0, (int)(height * 0.75), width, (int)(height * 0.25));
}

void draw() {
}

void keyPressed() {
  gray.loadPixels();
  for(int i = 0; i < gray.pixels.length; i++){
    gray.pixels[i] = color((int)red(gray.pixels[i]) * 0.9, (int)green(gray.pixels[i]) * 0.9, (int)blue(gray.pixels[i]) * 0.9);
  }
  gray.updatePixels();
  histogram = getHistogram(gray);
  
  drawAll();
}

PImage RGBtoGray(PImage img) {
  PImage result = createImage(img.width, img.height, RGB);

  for (int i = 0; i < img.pixels.length; i++) {
    float pixelAverage = bandsAverage(img.pixels[i]);
    result.pixels[i] = color(pixelAverage);
  }

  return result;
}

float bandsAverage(color pixel) {
  float red = red(pixel);
  float green = green(pixel);
  float blue = blue(pixel);

  return (red + green + blue) / 3;
}

void scaleImage(PImage img, float scale) {
  img.resize((int)(img.width * scale), (int)(img.height * scale));
}

int[] getHistogram(PImage img) {
  int[] result = new int[256];

  for (int i = 0; i < img.pixels.length; i++) {
    result[(int)bandsAverage(img.pixels[i])]++;
  }

  return result;
}

void drawHistogram(int x, int y, int w, int h) {
  noStroke();
  fill(255);
  rect(x, y, w, h);

  strokeWeight(w / 400.0f);
  stroke(0);
  strokeCap(SQUARE);

  int maxV = 0;

  for (int i = 0; i < 256; i++) {
    if (histogram[i] > maxV) maxV = histogram[i];
  }

  float lineH;
  float px;
  for (int i = 0; i < 256; i++) {
    px = map(i, 0, 256, x, x + w);
    lineH = map(histogram[i], 0, maxV, 0, h);
    line(px, y + h, px, y + h - lineH);
  }
}
