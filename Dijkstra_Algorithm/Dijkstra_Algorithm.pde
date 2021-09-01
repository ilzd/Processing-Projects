ArrayList<Vertex> vertexes = new ArrayList();
ArrayList<Vertex> unvisitedVertexes = new ArrayList();
Boolean found = false;
static final int linhas = 30, colunas = 30, infinity = 999999999;
float w, h;
Vertex destiny;

void setup() {
  size(600, 600);
  strokeWeight(0.1);
  stroke(255);
  //noStroke();
  w = width / linhas;
  h = height / colunas;
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      float random = random(0, 1);
      Vertex newVertex = new Vertex(i, j, random > 0.3, infinity);
      vertexes.add(newVertex);
      if (newVertex.visitable) {
        unvisitedVertexes.add(newVertex);
      }
    }
  }
  Vertex origin = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  while (!origin.visitable) {
    origin = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  }
  origin.dist = 0;
  origin.origin = true;

  destiny = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  while (!destiny.visitable) {
    destiny = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  }
  destiny.destiny = true;
}

void draw() {
  //background(255);
  frameRate(map(mouseX, 0, width, 50, 1));
  drawGraph();
  if (unvisitedVertexes.size() != 0 && !found) {
    findPath();
  } else {
    drawShortestPath(destiny.bestVertex);
    //noLoop();
  }
}

void findPath() {
  Vertex v = unvisitedVertexes.get(0);
  int index = 0;
  for (int i = 1; i < unvisitedVertexes.size(); i++) {
    Vertex aux = unvisitedVertexes.get(i);
    if (aux.dist < v.dist) {
      v = aux;
      index = i;
    }
  }
  if (v.dist == infinity) {
    found = true;
    return;
  }

  v.visited = true;
  v.close = false;
  unvisitedVertexes.remove(index);
  drawShortestPath(v);

  for (int i = 0; i < unvisitedVertexes.size(); i++) {
    Vertex aux = unvisitedVertexes.get(i);
    if (modulo(v.lin - aux.lin) + modulo(v.col - aux.col) == 1) {
      aux.close = true;
      if (v.dist + 1 < aux.dist) {
        aux.dist = v.dist + 1;
        aux.bestVertex = v;
        if (aux.destiny) {
          found = true;
        }
      }
    }
  }
}

int modulo(int num) {
  if (num >= 0) {
    return num;
  } else {
    return -num;
  }
}

void drawGraph() {
  //stroke(0);
  //strokeWeight(0.1);
  for (int i = 0; i < vertexes.size(); i++) {
    Vertex vertex = vertexes.get(i);
    if (!vertex.visitable) {
      fill(10);
    } else if (vertex.origin) {
      fill(255, 255, 60);
    } else  if (vertex.destiny) {
      fill(255, 65, 0);
    } else if (vertex.close) {
      fill(180, 70);
    } else if (vertex.visited) {
      fill(25, 255, 100, 100);
    } else {
      fill(110, 130, 180);
    }
    rect(vertex.lin * w, vertex.col * h, w, h);
  }
}

void drawShortestPath(Vertex v) {
  //stroke(0);
  //strokeWeight(0.1);
  //fill(255, 25, 60);
  fill(random(241, 255), random(18, 32), random(53, 77));
  while (v != null) {
    if (v.bestVertex != null) {
      rect(v.lin * w, v.col * h, w, h);
    }
    v = v.bestVertex;
  }
}