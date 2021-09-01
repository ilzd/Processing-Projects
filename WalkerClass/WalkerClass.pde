Mover[] movers = new Mover[10];
Liquid liquid;

void setup() {
  fullScreen();

  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(width), 0, random(25, 75));
  }

  liquid = new Liquid(0, height / 2, width / 2, height / 2, 2);
}

void draw() {
  background(0);
  liquid.display();
  for (int i = 0; i < movers.length; i++) {  
    movers[i].applyForce(new PVector(0, 0.1 * movers[i].mass));
    //movers[i].applyForce(new PVector(0.1, 0));
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
    if (movers[i].isInside(liquid)) movers[i].drag(liquid);
  }
}
