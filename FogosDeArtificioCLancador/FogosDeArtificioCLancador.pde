ArrayList<Fogo> fogos = new ArrayList<Fogo>();
ArrayList<Lancador> lancadores = new ArrayList<Lancador>();

void setup() {
  //size(600, 600);
  fullScreen();
  background(0);
}

void draw() {
  noStroke();
  fill(0, 40);
  rect(0, 0, width, height);

  for (int i = 0; i < fogos.size(); i++) {
    fogos.get(i).move();
    fogos.get(i).display();
    if (fogos.get(i).timer <= 0) {
      fogos.remove(i);
      println(fogos.size());
    }
  }

  for (int i = 0; i < lancadores.size(); i++) {
    lancadores.get(i).move();
    lancadores.get(i).display();
    if (lancadores.get(i).timer < 0) {
      lancadores.remove(i);
      println(lancadores.size());
    }
  }
}

void mousePressed() {
  lancadores.add(new Lancador(mouseX, mouseY));  
  //for (int i = 0; i < 100; i++) {
  //  fogos.add(new Fogo(mouseX, mouseY));
  //}
}
