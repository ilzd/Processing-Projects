int grays[] = new int[70];
int count = 1;
boolean sorting = false;

void setup(){
  size(1100, 200);
  noStroke();
  for(int i = 0; i < grays.length; i++){
    grays[i] = int(random(0, 255));
  }
  for(int i = 0; i < grays.length - 1; i++){
    fill(grays[i]);
    rect((width / grays.length) * i, 0, (width / grays.length) * (i + 1), height);
  }
}

void draw(){
  if(sorting){
    if(count > 0){
      count = 0;
      for(int i = 0; i < grays.length - 1; i++){
        if(grays[i] > grays[i + 1]){
          int aux = grays[i];
          grays[i] = grays[i + 1];
          grays[i + 1] = aux;
          count++;
          for(int j = 0; j < grays.length - 1; j++){
            fill(grays[j]);
            rect((width / grays.length) * j, 0, (width / grays.length) * (j + 1), height);
          }
        }
      }
    }
  }
}

void mousePressed(){
  sorting = true;
}