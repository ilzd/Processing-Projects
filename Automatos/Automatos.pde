Automato aut = new Automato();

void setup() {
  fullScreen();
  textAlign(CENTER, CENTER);
}

void draw() {
  aut.desenha();
}

void mousePressed() {
  aut.processaClique(mouseButton, mouseX, mouseY);
}

void keyPressed() {
  aut.processaTecla(key, mouseX, mouseY);
}

void keyReleased() {
  aut.processaTeclaSolta(key, mouseX, mouseY);
}
