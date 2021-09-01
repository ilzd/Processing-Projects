class Player {
  final static int BASE_RADIUS = 20; //Raio base do jogador
  Blob blob, lastBlob; //Blob atual e auxiliar
  ArrayList<Blob> blobs = new ArrayList(); //Array de blobs auxiliar
  color trackColor;
  int index;
  float colorDistTreshold = 15;
  boolean active = true;
  float posx, posy, prevx, prevy, radius = BASE_RADIUS;

  Player(int x, int y, color c, int index) {
    trackColor = c;
    this.index = index;
    blobs.add(new Blob(x, y));
  }

  void manageBlobs() {
    color pColor;
    boolean found;

    lastBlob = blob;
    blobs.clear();

    for (int x = 0; x < frame.width; x++) {
      for (int y = 0; y < frame.height; y++) {
        pColor = frame.pixels[x + y * frame.width];

        if (distSq(pColor, trackColor) < colorDistTreshold * colorDistTreshold) {
          found = false;
          for (Blob b : blobs) {
            if (b.isNear(x, y)) {
              found = true;
              b.grow(x, y);
              break;
            }
          }

          if (!found) {
            blobs.add(new Blob(x, y));
          }
        }
      }
    }

    if (blobs.size() == 1) {
      blob = blobs.get(0);
    } else if (blobs.size() > 1) {
      colorDistTreshold -= 0.5;
      colorDistTreshold = max(1, colorDistTreshold);
      blob = findBestBlob();
    } else if (blobs.size() == 0) {
      colorDistTreshold += 0.5;
      blob = lastBlob;
    }

    prevx = posx;
    prevy = posy;
    posx = map(blob.getCenterX(), (frame.width / players.size()) * index, (frame.width / players.size()) * (index + 1), 0, width);
    posx = constrain(posx, minBoundX, maxBoundX);
    posy = map((blob.getCenterY() - frame.height / 2) * players.size() + (frame.height / 2), 0, frame.height, 0, height);
    posy = constrain(posy, minBoundY, maxBoundY);

    if (distSq(prevx, prevy, posx, posy) < 144) {
      posx = prevx;
      posy = prevy;
    }
  }

  Blob findBestBlob() {
    int indexOfBest = -1, count1 = 0, count2 = 0, bestCount = 0;
    float valueOfBest = 999999;
    float dist;
    for (int i = 0; i < blobs.size(); i++) {
      Blob b = blobs.get(i);
      for (int x = b.minx; x <= b.maxx; x++) {
        for (int y = b.miny; y <= b.maxy; y++) {
          dist = distSq(frame.pixels[frame.width * y + x], trackColor);
          if (dist < valueOfBest) {
            count1 = 1;
            count2 = 0;
            indexOfBest = i;
            valueOfBest = dist;
          } else if (dist == valueOfBest) {
            if (i == indexOfBest) {
              count1++;
              bestCount = max(count1, bestCount);
            } else {
              count2++;
              if (count2 > bestCount) {
                count1 = 1;
                count2 = 0;
                indexOfBest = i;
              }
            }
          }
        }
      }
    }

    return blobs.get(indexOfBest);
  }

  ArrayList<Point> getSteps() {
    ArrayList<Point> steps = new ArrayList();
    float amountOfSteps = dist(prevx, prevy, posx, posy) / (2 * radius);
    PVector moveDir = new PVector(posx - prevx, posy - prevy).div(amountOfSteps);

    for (int j = 1; j < amountOfSteps; j++) {
      steps.add(new Point(prevx + moveDir.x * j, prevy + moveDir.y * j));
    }

    steps.add(new Point(posx, posy));

    return steps;
  }

  void display() {
    strokeWeight(5);
    stroke(255);
    fill(trackColor);
    ellipse(posx, posy, radius * 2, radius * 2);
  }

  void display(float respawn) {
    float resRad = map(respawn, 0, 1, radius * 3, radius);
    strokeWeight(5);
    stroke(trackColor);
    noFill();
    ellipse(posx, posy, radius * 2, radius * 2);
    stroke(255);
    strokeWeight(2);
    ellipse(posx, posy, resRad * 2, resRad * 2);
  }
}
