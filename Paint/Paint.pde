final int cols = 25, gridWidth = 500; //<>//
final int rows = 25;
color cores[][] = new color[cols][rows];
color noColor = color(255, 255, 255, 0), gridColor = color(255);
int bgRed = 100, bgGreen = 100, bgBlue = 100, selRed = 255, selGreen = 0, selBlue = 0;
ArrayList<color[][]> saves = new ArrayList<color[][]>();

void setup() {
  size(850, 500);
  frameRate(120);
  background(0);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      cores[i][j] = noColor;
    }
  }
  DrawColorPicker();
}

void draw() {
  noStroke();
  fill(bgRed, bgGreen, bgBlue);
  rect(0, 0, gridWidth, height);
  Painting();
  DrawGrid();
  if (mousePressed) {
    PaintBlock();
  }
}

void DrawGrid() {
  strokeWeight(1);
  stroke(gridColor);
  noFill();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //if (cores[i][j] == noColor) {
        rect((gridWidth / cols) * i, (height / rows) * j, gridWidth / cols, height / rows);
      //}
    }
  }
}

void Painting() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      noStroke();
      fill(cores[i][j]);
      rect((gridWidth / cols) * i, (height / rows) * j, gridWidth / cols, height / rows);
    }
  }
}

void PaintBlock() {
  int x = mouseX / (gridWidth / cols);
  int y = mouseY / (height / rows);
  if (x < cols && y < rows) {
    if (mouseButton == LEFT) {
      cores[x][y] = color(selRed, selGreen, selBlue);
    } else if (mouseButton == RIGHT) {
      cores[x][y] = noColor;
    } else {
      noStroke();
      fill(bgRed, bgGreen, bgBlue);
      rect(0, 0, gridWidth, height);
      Painting();
      selRed = (int) red(get(mouseX, mouseY));
      selGreen = (int) green(get(mouseX, mouseY));
      selBlue = (int) blue(get(mouseX, mouseY));
      DrawColorPicker();
    }
  }
}

void DrawColorPicker() {
  fill(0);
  noStroke();
  rect(gridWidth, 0, width, height);
  fill(255);
  textSize(20);
  text("BACKGROUND COLOR", gridWidth + 5, 25);
  text("PEN COLOR", gridWidth + 5, 120);
  text("PRESS 'BACKSPACE' TO CLEAR", gridWidth + 5, height - 30);
  text("PRESS 'SPACE' TO SAVE", gridWidth + 5, height - 5);
  text("PRESS 'SCROLL' TO COPY COLOR", gridWidth + 5, height - 55);
  text("PRESS 'RIGHT MOUSE' TO ERASE", gridWidth + 5, height - 80);
  text("PRESS 'LEFT MOUSE' TO PAINT", gridWidth + 5, height - 105);

  strokeWeight(1);
  stroke(gridColor);
  noFill();
  rect(gridWidth + 5, 30, 257, 20);
  rect(gridWidth + 5, 50, 257, 20);
  rect(gridWidth + 5, 70, 257, 20);
  rect(gridWidth + 5, 125, 257, 20);
  rect(gridWidth + 5, 145, 257, 20);
  rect(gridWidth + 5, 165, 257, 20);
  fill(bgRed, bgGreen, bgBlue);
  rect(gridWidth + 262, 30, 60, 60);
  fill(selRed, selGreen, selBlue);
  rect(gridWidth + 262, 125, 60, 60);
  for (int i = 0; i < 256; i++) {
    if (i != bgRed) {
      stroke(i, 0, 0);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 31, gridWidth + 6 + i, 49);
    if (i != bgGreen) {
      stroke(0, i, 0);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 51, gridWidth + 6 + i, 69);
    if (i != bgBlue) {
      stroke(0, 0, i);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 71, gridWidth + 6 + i, 89);


    if (i != selRed) {
      stroke(i, 0, 0);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 126, gridWidth + 6 + i, 144);
    if (i != selGreen) {
      stroke(0, i, 0);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 146, gridWidth + 6 + i, 164);
    if (i != selBlue) {
      stroke(0, 0, i);
    } else {
      stroke(255);
    }
    line(gridWidth + 6 + i, 166, gridWidth + 6 + i, 184);
  }
}

void chooseColor() {
  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY > 30 && mouseY < 50) {
      bgRed = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }
  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY > 50 && mouseY < 70) {
      bgGreen = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }
  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY > 70 && mouseY < 90) {
      bgBlue = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }

  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY > 125 && mouseY < 145) {
      selRed = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }
  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY >145 && mouseY < 165) {
      selGreen = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }
  if (mouseX > gridWidth + 5 && mouseX < gridWidth + 262) {
    if (mouseY > 165 && mouseY < 185) {
      selBlue = mouseX - gridWidth - 6;
      DrawColorPicker();
    }
  }
}

void mousePressed() {
  chooseColor();
}

void mouseReleased() {
  color[][] temp = new color[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      temp[i][j] = cores[i][j];
    }
  }
  if (saves.size() == 0) {
    saves.add(temp);
  } else {
    boolean equal = true;
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (temp[i][j] != saves.get(saves.size()- 1)[i][j]) {
          equal = false;
        }
      }
    }
    if (!equal) {
      saves.add(temp);
    }
  }
  println(saves.size());
}

void keyPressed() {
  if (key == ' ') {
    noStroke();
    fill(bgRed, bgGreen, bgBlue);
    rect(0, 0, gridWidth, height);
    Painting();
    PImage img = createImage(RGB, gridWidth, height);
    img = get(0, 0, gridWidth, height);
    img.save("image.png");
  } else if (key == BACKSPACE) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        cores[i][j] = noColor;
      }
    }
  } else if (key == 'z') {
    if (saves.size() > 1) {
      saves.remove(saves.size() - 1);
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          cores[i][j] = saves.get(saves.size() - 1)[i][j];
        }
      }
    } else {
      saves.clear();
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          cores[i][j] = noColor;
        }
      }
    }
    println(saves.size());
  }
}