void setup(){
  size(500, 500);
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0, width / 2, height, width / 2);
  line(height / 2, 0, height / 2, width);
}

void draw(){
}

void mousePressed(){
  int n = (int) map(mouseX, 1, width, 3, 50);
  float averageX = 0, averageY = 0;
  Ponto vetp[] = new Ponto[n];
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0, width / 2, height, width / 2);
  line(height / 2, 0, height / 2, width);
  for (int i = 0; i < vetp.length; i++){
    vetp[i] = new Ponto(random(-250, 250), random(-250, 250), i);
    vetp[i].getAngle();
    averageX += vetp[i].x;
    averageY += vetp[i].y;
    vetp[i].display();
  }
  
  stroke(0, 255, 0);
  strokeWeight(1);
  for (int i = 0; i < vetp.length - 1; i++){
    line(vetp[i].x + 250, vetp[i].y + 250, vetp[i + 1].x + 250, vetp[i + 1].y + 250);  
  }
  line(vetp[vetp.length - 1].x + 250, vetp[vetp.length - 1].y + 250, vetp[0].x + 250, vetp[0].y + 250);
  
  averageX /= n;
  averageY /= n;
  
  for (int i = 0; i < vetp.length; i++){
    vetp[i].x -= averageX;
    vetp[i].y -= averageY;
    vetp[i].getAngle();
    vetp[i].x += averageX;
    vetp[i].y += averageY;
  }
  
  int c = 1;
  while(c > 0){
    c = 0;
    for (int i = 0; i < vetp.length - 1; i++){
      if (vetp[i].o < vetp[i + 1].o){
      Ponto aux = vetp[i];
      vetp[i] = vetp[i + 1];
      vetp[i + 1] = aux;
      c++;
      }
    } 
  }
  
  stroke(0, 0, 255);
  strokeWeight(2);
  for (int i = 0; i < vetp.length - 1; i++){
    line(vetp[i].x + 250, vetp[i].y + 250, vetp[i + 1].x + 250, vetp[i + 1].y + 250);  
  }
  line(vetp[vetp.length - 1].x + 250, vetp[vetp.length - 1].y + 250, vetp[0].x + 250, vetp[0].y + 250);
    
}