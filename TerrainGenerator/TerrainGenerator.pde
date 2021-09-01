int rols = 100, cols = 100, space = 35;
float extremes = 1, smoothness = 200, cx = 0, cy = 0, cz = 0;

public void setup() {
  fullScreen(P3D);
  noStroke();
  //stroke(255);
  strokeWeight(0.1f);
  smooth(16);
  frameRate(60);
}

public void draw() {
  background(0);
  lights();
  camera((rols / 2) * space, -500, -400, (rols / 2) * space, 0, 0, 0, 1, 0);
  translate(cx, cy, cz);

  for (int i = 0; i < rols; i++) {
    for (int j = 0; j < cols; j++) {
      float x1 = i * space, x2 = (i + 1) * space;
      float y1 = j * space, y2 = (j + 1) * space;

      //float baseNoise = noise((x1 + frameCount * 10) / smoothness, (y1 + frameCount * 10) / smoothness); 

      //fill(map(sqrt(baseNoise), 0, 1, 255, 0), map(sqrt(sqrt(baseNoise)), 0, 1, 150, 0), map(sqrt(baseNoise), 0, 1, 100, 0));

      //beginShape(TRIANGLE);
      //vertex(x1, map(noise((x1 + frameCount * 10) / smoothness, (y1 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y1);
      //vertex(x2, map(noise((x2 + frameCount * 10) / smoothness, (y1 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y1);
      //vertex(x1, map(noise((x1 + frameCount * 10) / smoothness, (y2 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y2);
      //endShape();

      //beginShape(TRIANGLE);
      //vertex(x2, map(noise((x2 + frameCount * 10) / smoothness, (y1 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y1);
      //vertex(x1, map(noise((x1 + frameCount * 10) / smoothness, (y2 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y2);
      //vertex(x2, map(noise((x2 + frameCount * 10) / smoothness, (y2 + frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y2);
      //endShape();
      
      float baseNoise = noise((frameCount * 10) / smoothness, (y1 + frameCount * 10) / smoothness); 

      fill(map(sqrt(baseNoise), 0, 1, 255, 0), map(sqrt(sqrt(baseNoise)), 0, 1, 150, 0), map(sqrt(baseNoise), 0, 1, 100, 0));

      beginShape(TRIANGLE);
      vertex(x1, map(noise((frameCount * 5) / smoothness, (frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y1);
      vertex(x2, map(noise((frameCount * 2) / smoothness, (frameCount * 6) / smoothness), 0, 1, -extremes, extremes), y1);
      vertex(x1, map(noise((frameCount * 1) / smoothness, (frameCount * 3) / smoothness), 0, 1, -extremes, extremes), y2);
      endShape();

      beginShape(TRIANGLE);
      vertex(x2, map(noise((frameCount * 5) / smoothness, (frameCount * 10) / smoothness), 0, 1, -extremes, extremes), y1);
      vertex(x1, map(noise((frameCount * 1) / smoothness, (frameCount * 6) / smoothness), 0, 1, -extremes, extremes), y2);
      vertex(x2, map(noise((frameCount * 1) / smoothness, (frameCount * 3) / smoothness), 0, 1, -extremes, extremes), y2);
      endShape();
    }

    if (keyPressed) {
      switch(key) {
        case('w'):
        cz -= 0.1f;
        break;
        case('s'):
        cz += 0.1f;
        break;
        case('a'):
        cx -= 0.1f;
        break;
        case('d'):
        cx += 0.1f;
        break;
        case('q'):
        cy -= 0.3f;
        break;
        case('e'):
        cy += 0.3f;
        break;
        case('o'):
        smoothness += 0.1f;
        break;
        case('p'):
        smoothness = max(1, smoothness - 0.1f);
        break;
        case('l'):
        extremes += 0.1f;
        break;
        case('ç'):
        extremes = max(0, extremes - 0.1f);
      default:
        break;
      }
    }
  }
}
