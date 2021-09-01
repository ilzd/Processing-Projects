class RDImage {
  int pointSize, rows, cols;
  int[][] colorMap;

  RDImage(int pointSize, int rows, int cols) {
    this.pointSize = pointSize; 
    this.rows = rows; 
    this.cols = cols;
    this.colorMap = new int[cols][rows];

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        colorMap[i][j] = round(random(0, 255));
      }
    }
  }

  RDImage(int pointSize, int rows, int cols, int[][] colorMap) {
    this.pointSize = pointSize; 
    this.rows = rows; 
    this.cols = cols;
    this.colorMap = new int[cols][rows];

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        this.colorMap[i][j] = colorMap[i][j];
      }
    }
  }

  void display(int x, int y) {
    noStroke();
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        fill(colorMap[i][j]);
        rect(x + i * pointSize, y + j * pointSize, pointSize, pointSize);
      }
    }
  }

  void shiftRect(int x, int y, int w, int h) {
    for (int j = y; j < y + h; j++) {
      for (int i = x; i < x + w; i++) {
        this.colorMap[i - 1][j] = this.colorMap[i][j];
      }
      this.colorMap[x + w - 1][j] = round(random(0, 255));
    }
  }

  RDImage copy() {
    return new RDImage(this.pointSize, this.rows, this.cols, this.colorMap);
  }
}
