PImage imageToGray(PImage img) {
  PImage result = new PImage(img.width, img.height, RGB);

  for (int i = 0; i < img.pixels.length; i++) {
    result.pixels[i] = color(pixelAverage(img.pixels[i]));
  }

  return result;
}

PImage grayToBinary(PImage img) {
  PImage result = createImage(img.width, img.height, RGB);

  int[] histogram = getImageHistogram(img);
  float[] normalizedHistogram = getNormalizedData(histogram);
  int threshold = getOtsuThreshold(normalizedHistogram);

  for (int i = 0; i < img.pixels.length; i++) {
    result.pixels[i] = color((red(img.pixels[i]) > threshold) ? 255 : 0);
  }

  return result;
}

float pixelAverage(color c) {
  return (red(c) + green(c) + blue(c)) / 3;
}

int getOtsuThreshold(float[] data) {
  float minVariance = INF;
  int bestThresholdSoFar = 0;

  for (int t = 0; t < data.length; t++) {

    float q1 = 0;
    for (int i = 0; i < t; i++) {
      q1 += data[i];
    }

    float q2 = 0;
    for (int i = t; i < data.length; i++) {
      q2 += data[i];
    }

    float u1 = 0;
    for (int i = 0; i < t; i++) {
      u1 += (i * data[i]) /  q1;
    }

    float u2 = 0;
    for (int i = t; i < data.length; i++) {
      u2 += (i * data[i]) /  q2;
    }

    float a1 = 0;
    for (int i = 0; i < t; i++) {
      a1 += pow(i - u1, 2) * (data[i] / q1);
    }

    float a2 = 0;
    for (int i = t; i < data.length; i++) {
      a2 += pow(i - u2, 2) * (data[i] / q2);
    }

    float finalVar = q1 * a1 + q2 * a2;

    if (finalVar < minVariance) {
      minVariance = finalVar;
      bestThresholdSoFar = t;
    }
  }

  return bestThresholdSoFar;
}

int[] getImageHistogram(PImage img) {
  int[] histogram = new int[256];

  for (int i = 0; i < img.pixels.length; i++) {
    histogram[round(red(img.pixels[i]))]++;
  }

  return histogram;
}

float[] getNormalizedData(int[] data) {
  int dataCount = 0;
  float[] normalizedData = new float[data.length];

  for (int i = 0; i < data.length; i++) {
    dataCount += data[i];
  }

  for (int i = 0; i < data.length; i++) {
    normalizedData[i] = (float)data[i] / dataCount;
  }

  return normalizedData;
}

void findPOI(PImage img) {
  xi = -1;
  yi = -1;
  xf = -1;
  yf = -1;
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = y * img.width + x;

      if (red(img.pixels[index]) < 127) {
        if (x < xi || xi == -1) xi = x;
        if (x > xf || xf == -1) xf = x;
        if (y < yi || yi == -1) yi = y;
        if (y > yf || yf == -1) yf = y;
      }
    }
  }
}

PImage applyMask(PImage image) {
  PImage bluredImage = createImage(image.width, image.height, RGB);
  int matrixRange = mask.length / 2;
  float totalWeight = 0;

  for (int i = 0; i < mask.length; i++) {
    for (int j = 0; j < mask[i].length; j++) {
      totalWeight += mask[i][j];
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
      for (int i = 0; i < mask.length; i++) {
        for (int j = 0; j < mask[i].length; j++) {
          index = constrain(y + j - matrixRange, 0, bluredImage.height - 1) * bluredImage.width + constrain(x + i - matrixRange, 0, bluredImage.width - 1);
          bluredPixel[0] += red(image.pixels[index]) * mask[i][j]; 
          bluredPixel[1] += green(image.pixels[index]) * mask[i][j]; 
          bluredPixel[2] += blue(image.pixels[index]) * mask[i][j];
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
