class Ponto{
  float x, y, o;
  int index;
  
  Ponto(float x_, float y_, int i_){
    x = x_;
    y = y_;
    index = i_ + 1;
  }
  
  void getAngle(){
    o = x / sqrt(x*x + y*y);
    o = acos(o) * 180 / PI;
      if (y < 0) {
      o = 360 - o;
      }
  }
  
  void display(){
  ellipseMode(CENTER);
  fill(255, 0, 0);
  noStroke();
  ellipse(x + 250, y + 250, 10, 10);
  int len = 16;
  textSize(len);
  text(index, x + 250, y + 250);
  }
  
}