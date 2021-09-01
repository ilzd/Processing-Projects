int rows = 200, cols = 200, space = 50;
float cx = 0, cy = 1000, cz = -550, extremes = 100, smoothness = 300;

PVector[][] points = new PVector[cols][rows];


void setup() {
  fullScreen(P3D);
  smooth(16);
  noStroke();
  strokeWeight(.1);
  //stroke(255, 255, 255, 100);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      points[i][j] = new PVector(i * space, 0, j * space);
    }
  }
}

void draw() {
  background(0);
  lights();
  directionalLight(150, 150, 150, 1, 0.1, 1);

  camera((cols / 2) * space, -800, -500, (cols / 2) * space, 0, 0, 0, 1, 0);
  translate(cx, cy, cz);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      PVector pt = points[i][j];
      pt.y = map(noise((pt.x + frameCount) / smoothness, (pt.z + frameCount) / smoothness, frameCount / (smoothness / 8f) - ((pt.x / 2) / smoothness) + ((pt.z / 2) / smoothness)), 0, 1, -extremes, extremes);
    }
  }

  for (int i = 0; i < cols - 1; i++) {
    for (int j = 0; j < rows - 1; j++) {
      PVector pt1 = points[i][j], pt2 = points[i + 1][j], pt3 = points[i][j + 1], pt4 = points[i + 1][j + 1];

      fill(map(pt1.y, -extremes, extremes, 255,0), map(pt1.y, -extremes, extremes, 0, 0), map(pt1.y, -extremes, extremes, 0, 255));

      beginShape(TRIANGLE);
      vertex(pt1.x, pt1.y, pt1.z);
      vertex(pt2.x, pt2.y, pt2.z);
      vertex(pt3.x, pt3.y, pt3.z);
      endShape();

      beginShape(TRIANGLE);
      vertex(pt2.x, pt2.y, pt2.z);
      vertex(pt3.x, pt3.y, pt3.z);
      vertex(pt4.x, pt4.y, pt4.z);
      endShape();
    }
  }

  if (keyPressed) {
    switch(key) {
      case('w'):
      cz -= 10f;
      break;
      case('s'):
      cz += 10f;
      break;
      case('a'):
      cx -= 10f;
      break;
      case('d'):
      cx += 10f;
      break;
      case('q'):
      cy -= 30f;
      break;
      case('e'):
      cy += 30f;
      break;
      case('o'):
      smoothness += 10f;
      break;
      case('p'):
      smoothness = max(1, smoothness - 10f);
      break;
      case('l'):
      extremes += 10f;
      break;
      case('ç'):
      extremes = max(1, extremes - 10f);
    default:
      break;
    }
  }
}

void keyPressed() {
  if (key == ' ') saveFrame("frame####.png");
}

void mousePressed(){
  //noLoop();
}
