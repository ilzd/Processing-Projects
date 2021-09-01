Stick stk1, stk2;

void setup() {
  fullScreen();

  stk1 = new Stick(width * 0.33, height / 2, 0);
  stk2 = new Stick(width * 0.66, height / 2, 0);
  background(0);
  
  frameRate(999);
  strokeWeight(0.1);
}

void draw() {
  //background(0);
  pushMatrix();
  stk1.update();
  popMatrix();
  stk2.update();
}

void keyPressed(){
  saveFrame(frameCount + ".png");
}
