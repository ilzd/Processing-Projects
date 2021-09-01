class Queue {
  ArrayList<Person> people = new ArrayList();
  float chance, p, u;
  ArrayList<Server> servers = new ArrayList();
  int serveTime, servedPeople, time;
  boolean drawingQueue = true;

  Queue(int qntServers, float chance, int serveTime) {
    this.serveTime = serveTime;
    for (int i = 0; i < qntServers; i++) {
      servers.add(new Server());
    }
    this.chance = chance;
    this.atualiza();
  }

  void addServer() {
    servers.add(new Server());
  }

  void update() {
    for (Server s : servers) {
      if (s.update()) {
        s.reset();
        if (people.size() > 0) {
          s.serve(people.remove(0), serveTime);
          servedPeople++;
        };
      }
    }

    if (random(0, 1) < chance) {
      people.add(new Person());
    }
    time++;
  }

  void atualiza() {
    u = 1f / serveTime;
    p = round(100f *(chance / (servers.size() * u))) / 100f;
  }

  void drawQueue() {
    for (int i = 0; i < servers.size(); i++) {
      servers.get(i).display(25 + i * 2 * Person.diameter, 25, Person.diameter, Person.diameter);
    }

    float w = Person.diameter * 1.1;
    float x = Person.diameter * 1.1;
    float y = Person.diameter * 4.5;
    int dirX = 1;
    int turning = 0;
    for (int i = 0; i < people.size(); i++) {
      noStroke();
      fill(people.get(i).c);
      ellipse(x, y, Person.diameter, Person.diameter);
      if (x + w * dirX > width - w || x + w * dirX < w) {
        if (turning == 2) {
          dirX *= -1;
          turning = 0;
        } else {
          y += w;
          turning++;
        }
      } else {
        x += w * dirX;
      }
    }

    stroke(0);
    line(0, Person.diameter * 3.5, Person.diameter * 0.4, Person.diameter * 3.5);
    line(Person.diameter * 1.8, Person.diameter * 3.5, width, Person.diameter * 3.5);
  }

  void drawGraphs() {
    int size = 200;
    textSize(14);


    //DESENHANDO CHANCE DE TER N CLIENTES
    pushMatrix();

    translate(100, 300);
    strokeWeight(3);
    stroke(0);
    line(0, 0, size, 0);
    line(0, -size, 0, 0);

    fill(255);
    text("Chance de ter n clientes", 185, -size - 50);
    text("1", -5, -size + 10);
    text("0", -5, 15);
    text("1", size, 15);
    text("Pn", 5, -size - 10);
    text("P", size + 15, 5);
    text("S = " + servers.size(), size, - size);
    fill(255, 0, 0);
    text("n = 0", size, - size + 40);
    fill(0, 255, 0);
    text("n = 1", size, - size + 55);
    fill(255, 0, 255);
    text("n = 5", size, - size + 70);
    fill(255, 255, 0);
    text("n = 10", size, - size + 85);

    strokeWeight(0.5);

    stroke(255, 0, 0);
    for (float i = 0; i < 1; i += 0.01) {
      line(i * size, -calculaPn(0, i) * size, (i + 0.01) * size, -calculaPn(0, i + 0.01) * size);
    }

    stroke(0, 255, 0);
    for (float i = 0; i < 1; i += 0.01) {
      line(i * size, -calculaPn(1, i) * size, (i + 0.01) * size, -calculaPn(1, i + 0.01) * size);
    }

    stroke(255, 0, 255);
    for (float i = 0; i < 1; i += 0.01) {
      line(i * size, -calculaPn(5, i) * size, (i + 0.01) * size, -calculaPn(5, i + 0.01) * size);
    }

    stroke(255, 255, 0);
    for (float i = 0; i < 1; i += 0.01) {
      line(i * size, -calculaPn(10, i) * size, (i + 0.01) * size, -calculaPn(10, i + 0.01) * size);
    }

    popMatrix();

    //DESENHANDO NUMERO MÉDIO DE CLIENTES NA FILA 
    pushMatrix();

    translate(300 + size, 300);
    strokeWeight(3);
    stroke(0);
    line(0, 0, size, 0);
    line(0, -size, 0, 0);

    fill(255);
    text("Número médio de clientes no sistema e na fila", 250, -size - 50);
    text("" + size / 5, -5, -size + 10);
    text("0", -5, 15);
    text("1", size, 15);
    text("P", size + 15, 5);
    text("S = " + servers.size(), size, - size);
    fill(255, 0, 0);
    text("Lq", size - size / 2, - size + 40);
    fill(255, 255, 0);
    text("Ls", size - size / 2, - size + 70);

    strokeWeight(1);

    stroke(255, 0, 0);
    for (float i = 0; i < 0.99; i += 0.005) { 
      float Lqi = min(size, calculaLq(i) * 5), Lqi2 = min(size, calculaLq(i + 0.005) * 5);
      line(i * size, -Lqi, (i + 0.01) * size, -Lqi2);
      if (Lqi2 == size) break;
    }

    stroke(255, 255, 0);
    for (float i = 0; i < 0.99; i += 0.005) { 
      float Lqi =  min(size, calculaLs(i) * 5), Lqi2 =  min(size, calculaLs(i + 0.005) * 5);
      line(i * size, -Lqi, (i + 0.01) * size, -Lqi2);
      if (Lqi2 == size) break;
    }

    popMatrix();

    //DESENHANDO CHANCE DO TAMANHO DA FILA SER 0
    pushMatrix();

    translate(100, 450 + size);
    strokeWeight(3);
    stroke(0);
    line(0, 0, size, 0);
    line(0, -size, 0, 0);

    fill(255);
    text("Probabilidade do tamanho da fila ser 0", 220, -size - 50);
    text("1", -5, -size + 10);
    text("0", -5, 15);
    text("1", size, 15);
    text("P", size + 15, 5);
    text("S = " + servers.size(), size, - size);
    fill(255, 0, 0);

    strokeWeight(1);

    stroke(255, 0, 0);
    for (float i = 0; i < 1; i += 0.01) {
      line(i * size, -calculaChanceFila0(i) * size, (i + 0.01) * size, -calculaChanceFila0(i + 0.01) * size);
    }

    popMatrix();

    //DESENHANDO NUMERO MÉDIO DE CLIENTES NA FILA 
    pushMatrix();

    translate(300 + size, 450 + size);
    strokeWeight(3);
    stroke(0);
    line(0, 0, size, 0);
    line(0, -size, 0, 0);

    fill(255);
    text("Tempo médio de espera na fila", 210, -size - 50);
    text("" + size / 5, -5, -size + 10);
    text("0", -5, 15);
    text("1", size, 15);
    text("P", size + 15, 5);
    text("S = " + servers.size(), size, - size);

    strokeWeight(1);

    stroke(255, 0, 0);
    for (float i = 0; i < 0.99; i += 0.005) { 
      float Lqi = min(size, calculaTempoNaFila(i) * 5), Lqi2 = min(size, calculaTempoNaFila(i + 0.005) * 5);
      line(i * size, -Lqi, (i + 0.005) * size, -Lqi2);
      if (Lqi2 == size) break;
    }

    popMatrix();
  }

  void display() {
    background(100);

    if (drawingQueue) {
      drawQueue();
    } else {
      drawGraphs();
    }

    fill(255, 150);
    textSize(20);
    text("Tamanho da fila: " + people.size(), width - 20, 30);
    text("Tempo: " + time, width - 20, 55);
    text("Pessoas servidas: " + servedPeople, width - 20, 80); 
    text("P: " + p, width - 20, 105);

    text("Servidores (q adiciona, w remove): " + servers.size(), width - 20, 150);
    text("Chance (a aumenta, s diminui): " + round(chance * 100) + "%", width - 20, 175);
    text("Tempo de atendimento (z aumenta, x diminui): " + serveTime, width - 20, 200);

    text("Pressione G para ver os gráficos", width - 20, height - 70);
    text("Pressione ESPAÇO para resetar a fila", width - 20, height - 45);
    text("Tecla 1 = 1 t, Tecla 2 = 10 t, Tecla 3 = 100 t, Tecla 4 = 1000 t, Tecla 5 = 10000 t", width - 20, height - 20);
  }

  double calculaOn(int n) {
    double result = 0;
    int S = servers.size();

    if (n <= S) {
      result = ((1/fat(n)) * (pow(chance/u, n)));
    } else {
      result = (1 / ( (fat(S) * (pow(S, n - S)) )) * (pow(chance/u, n)));
    }

    return result;
  }

  float calculaPn(int n, float p) {
    float result = 0;
    int S = servers.size();

    float somatorio = 0;

    for (int i = 0; i < S; i++) {
      somatorio += (pow(S, i)/fat(i)) * pow(p, i);
    }

    float P0 = 1 / (somatorio + (pow(S, S) / fat(S)) * pow(p, S) * (1 / (1 - p) ));

    result = (pow(S, n) / fat(n)) * pow(p, n) * P0;

    return result;
  }

  float calculaLq(float p) {
    float result = 0;

    result = p * ((calculaPn(servers.size(), p)) / pow(1 - p, 2));

    return result;
  }

  float calculaLs(float p) {
    float result = 0;

    result = servers.size() * p + p * ((calculaPn(servers.size(), p)) / pow(1 - p, 2));

    return result;
  }

  float calculaChanceFila0(float p) {
    float result = 0;
    result = 1 - calculaPn(servers.size(), p) /  (1 - p);
    return result;
  }

  float calculaTempoNaFila(float p) {
    int S = servers.size();
    float result = 0;
    result = 1 / u + (calculaPn(S, p) / (S * u)) * (1 / pow(1 - p, 2));

    return result;
  }
}

class Person {
  static final int diameter = 65;
  color c = color(random(0, 255), random(0, 255), random(0, 255));
}

class Server {
  int serveState;
  Person p;

  Server() {
    serveState = 0;
  }

  void reset() {
    p = null;
  }

  void serve(Person p, int serveTime) {
    serveState = serveTime;
    this.p = p;
  }

  boolean update() {
    serveState = max(0, serveState - 1);
    return serveState <= 0;
  }

  void display(float x, float y, float w, float h) {
    noFill();
    strokeWeight(5);
    stroke(0);
    rect(x, y, w, w);
    fill(0);
    ellipse(x + w / 2, y + w / 2, w * 0.8, w * 0.8);
    textAlign(CENTER);
    fill(255);
    text(serveState, x + w / 2, y + w / 2 + 10);
    textAlign(RIGHT);

    if (p != null) {
      noStroke();
      fill(p.c);
      ellipse(x + w / 2, y + w * 2, w, w);
    }
  }
}
