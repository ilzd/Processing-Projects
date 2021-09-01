import processing.video.*;

Capture cam;
PImage maze;
int capW = 300, capH = 300, mazeW = 100, mazeH = 100, ori = -1, des = -1;
int[][] mazeData = new int[mazeW][mazeH];
boolean captured = false, reflected = false, selected = false;

ArrayList<Vertex> vertexes = new ArrayList();
ArrayList<Vertex> unvisitedVertexes = new ArrayList();
Boolean found = false;
final int linhas = mazeW, colunas = mazeH, infinity = 999999999;
float w, h;
Vertex destiny;

void setup() {
  size(600, 600);
  cam = new Capture(this, 640, 480, 30);
  cam.start();

  strokeWeight(0.1);
  stroke(255);
  //noStroke();
  w = width / linhas;
  h = height / colunas;
}

void draw() {
  if (!captured) {
    if (reflected)
      drawCapturer();
  } else {
    drawGraph();
    if (selected) {
      frameRate(map(mouseX, 0, width, 999, 1));
      if (unvisitedVertexes.size() != 0 && !found) {
        findPath();
      } else {
        drawShortestPath(destiny.bestVertex);
        //noLoop();
      }
    }
  }
}

void captureEvent(Capture c) {
  reflected = false;
  c.read();
  reflectImage();
}

void keyPressed() {
  if (captured) {
    frameRate(999);
    background(0);
    ori = -1;
    des = -1;
    captured = false;
    selected = false;
    vertexes.clear();
    unvisitedVertexes.clear();
    found = false;
    cam.start();
  } else {
    captured = true;
    stroke(0);
    maze = createImage(capW, capH, RGB);
    maze = cam.get(640 / 2 - capW / 2, 480 / 2 - capH / 2, capW, capH);
    getMaze();
    createVertexes();
    cam.stop();
    background(0);
  }
}

void drawCapturer() {
  image(cam, (width - 640) / 2, (height - 480) / 2);
  strokeWeight(2);
  stroke(255, 0, 0);
  noFill();
  rect(width / 2 - capW / 2, height / 2 - capH / 2, capW, capH);
}

void getMaze() {
  for (int i = 0; i < mazeW; i++) {
    for (int j = 0; j < mazeH; j++) {
      int brilho = 0;
      for (int x = 0; x < capW / mazeW; x++) {
        for (int y = 0; y < capH / mazeH; y++) {
          brilho += brightness(maze.pixels[j * capW * (capH / mazeH) + y * capW + i * (capW / mazeW) + x]);
        }
      }
      brilho /= max(1, ((capW / mazeW) * (capH / mazeH)));
      if (brilho >= 120) {
        mazeData[i][j] = 0;
      } else {
        mazeData[i][j] = 1;
      }
    }
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
  strokeWeight(0.1);
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

void createVertexes() {
  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      Vertex newVertex = new Vertex(i, j, mazeData[i][j] == 0, infinity);
      vertexes.add(newVertex);
      if (newVertex.visitable) {
        unvisitedVertexes.add(newVertex);
      }
    }
  }

  //Vertex origin = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  //while (!origin.visitable) {
  //  origin = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  //}
  ////origin.dist = 0;
  ////origin.origin = true;

  //destiny = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  //while (!destiny.visitable) {
  //  destiny = unvisitedVertexes.get(int(random(0, unvisitedVertexes.size() - 1)));
  //}

  //destiny.destiny = true;
}

void reflectImage() {
  if (!reflected) {
    cam.loadPixels();
    for (int i = 0; i < cam.width / 2; i++) {
      for (int j = 0; j < cam.height; j++) {
        color aux = cam.pixels[j * cam.width + i];
        cam.pixels[j * cam.width + i] = cam.pixels[j * cam.width + cam.width - i - 1];
        cam.pixels[j * cam.width + cam.width - i - 1] = aux;
      }
    }
    cam.updatePixels();
    reflected = true;
  }
}

void mousePressed() {
  if (captured) {
    if (ori == -1) {
      ori = 1;
      int ox = (int)(mouseX / w);
      int oy = (int)(mouseY / h);
      for (int i = 0; i < unvisitedVertexes.size(); i++) {
        Vertex v = unvisitedVertexes.get(i);
        if (v.col == oy && v.lin == ox) {
          v.origin = true;
          v.dist = 0;
          break;
        }
      }
    } else if (des == -1) {
      des = 1;
      int dx = (int)(mouseX / w);
      int dy = (int)(mouseY / h);
      for (int i = 0; i < unvisitedVertexes.size(); i++) {
        Vertex v = unvisitedVertexes.get(i);
        if (v.col == dy && v.lin == dx) {
          v.destiny = true;
          selected = true;
          destiny = v;
          break;
        }
      }
    }
  }
}
