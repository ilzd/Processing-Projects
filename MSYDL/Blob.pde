class Blob {
  final static int MAX_DISTANCE_THRESHOLD = 30;
  int minx, miny, maxx, maxy;

  Blob(int x, int y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }

  boolean isNear(float x, float y) {
    float halfW = (maxx - minx) / 2;
    float halfH = (maxy - miny) / 2;

    float distW = distSq(minx + halfW, x) - halfW * halfW;
    float distH = distSq(miny + halfH, y) - halfH * halfH;

    if (distW + distH < MAX_DISTANCE_THRESHOLD * MAX_DISTANCE_THRESHOLD) {
      return true;
    } else {
      return false;
    }
  }

  void grow(float x, float y) {
    minx = (int)min(x, minx);
    miny = (int)min(y, miny);
    maxx = (int)max(x, maxx);
    maxy = (int)max(y, maxy);
  }

  float getCenterX() {
    return (maxx + minx) / 2;
  }

  float getCenterY() {
    return (maxy + miny) / 2;
  }
}
