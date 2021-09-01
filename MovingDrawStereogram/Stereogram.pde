float DPI = 72;
int E = round(DPI * 2.5);
float mu = 1/3.0;

float[][] getDepthMapFromImage(PImage depthMap) {

  float[][] depthLevels = new float[depthMap.width][depthMap.height];
  for (int i = 0; i < depthMap.pixels.length; i++) {
    depthLevels[i % depthMap.width][i / depthMap.width] = map(depthMap.pixels[i] & 0xFF, 0, 255, 0, 1);
  }

  return depthLevels;
}

int[][] getConstraintsFromDepthLevels(float[][] depthLevels) {
  int[][] constraints = new int[depthLevels.length][depthLevels[0].length];

  for (int i = 0; i < constraints.length; i++) {
    for (int j = 0; j < constraints[0].length; j++) {
      constraints[i][j] = j * constraints.length + i;
    }
  }

  for (int i = 0; i < constraints.length; i++) {
    for (int j = 0; j < constraints[0].length; j++) {
      int s = getSeparationFromDepthValue(depthLevels[i][j]);
      
      int left = i - s / 2;
      int right = left + s;
      if (left >= 0 && right < constraints.length) {
        constraints[left][j] = constraints[right][j];
      }
    }
  }

  return constraints;
}

PImage getAutostereogramFromConstraints(int[][] constraints) {
  PImage autostereogram = createImage(constraints.length, constraints[0].length, RGB);

  for (int j = 0; j < constraints[0].length; j++) {
    for (int i = constraints.length - 1; i >= 0; i--) {
      if (constraints[i][j] == j * constraints.length + i) {
        autostereogram.pixels[j * autostereogram.width + i] = 255<<24|(int)random(0, 255)<<16|(int)random(0, 255)<<8|(int)random(0, 255);
      } else {
        autostereogram.pixels[j * autostereogram.width + i] = autostereogram.pixels[constraints[i][j]];
      }
    }
  }

  return autostereogram;
}

int getSeparationFromDepthValue(float z) {
  return round(E * ((1 - mu * z) / (2 - mu * z)));
}
