Drop drops[] = new Drop[500];
int tempo = 0, trovaotempo = (int) random(0, 250), trovaoduracao = (int) random(10, 20);
ArrayList<Ray> rays = new ArrayList<Ray>();
boolean loop = true;
int luz = 0;

void setup() {
  fullScreen();
  //size(900, 600);
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
  rays.add(new Ray(random(0, width), 0, random(4, 8)));
  rays.get(0).Grow();
}

void draw() {
  fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  if (tempo >= trovaotempo) {
    background(180);
    for (int i = 0; i < rays.size(); i++) {
      rays.get(i).Display();
    }
    if (tempo == trovaotempo + trovaoduracao) {
      trovaotempo = (int) random(0, 250);
      trovaoduracao = (int) random(10, 20);
      tempo = 0;
      rays.clear();
      rays.add(new Ray(random(0, width), 0, random(4, 8)));
      rays.get(0).Grow();
    }
  }

  for (int i = 0; i < drops.length; i++) {
    drops[i].Move();
    drops[i].Display();
  }

  tempo = tempo + 1;
}

void keyPressed(){
  if (loop){
    loop = false;
    noLoop();
  } else {
    loop = true;
    loop();
  }
}
