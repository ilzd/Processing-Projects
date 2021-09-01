ArrayList<Place> places = new ArrayList();
Place actual = new Place();
float size;

int[][] maze = { 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 0, 0, 0, 1, 1}, 
  {1, 0, 1, 1, 1, 0, 1, 0, 1, 1}, 
  {1, 0, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 0, 1, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 1, 0, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 1, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 2}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, };

void setup() {
  size(500, 500);
  frameRate(8);
  size = width / maze.length;

  Place place = new Place();
  while (maze[place.y][place.x] == 1) {
    place.x = (int) random(0, maze.length);
    place.y = (int) random(0, maze[0].length);
  }

  places.add(place);
  if (maze[place.y][place.x] != 2) {
    maze[place.y][place.x] = 3;
  }
  findPlaces(places.get(0));
}

void draw() {
  background(0);
  solveMaze();
  drawMaze();
  drawPath();
}

void drawMaze() {
  stroke(255);
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[0].length; j++) {
      if (maze[j][i] == 1) {
        fill(0);
      } else if (maze[j][i] == 2) {
        fill(0, 255, 0);
      } else if (maze[j][i] == 3) {
        fill(255, 150, 150);
      } else {
        fill(255);
      }
      rect(i * size, j * size, (i + 1) * size, (j + 1) * size);
    }
  }
}

void drawPath() {
  for (int i = 0; i < places.size(); i++) {
    fill(150, 150, 255);
    rect(places.get(i).x * size, places.get(i).y * size, size, size);
  }
  fill(0, 0, 255);
  rect(actual.x * size, actual.y * size, size, size);
}

void solveMaze() {
  if (maze[actual.y][actual.x] != 2  && places.size() != 0) {
    if (actual.places.size() == 0) {
      actual = places.get(places.size() - 1);
      places.remove(places.size() - 1);
      if (actual.places.size() != 0) {
        places.add(actual);
      }
    } else {
      Place aux = actual;
      actual = actual.places.get(0);
      if (maze[actual.y][actual.x] != 2) {
        maze[actual.y][actual.x] = 3;
      }
      aux.places.remove(0);
      findPlaces(actual);
      if (actual.places.size() != -1) {
        places.add(actual);
      }
    }
  }
}

void findPlaces(Place place) {
  int linB, colB, lin, col;
  if (places.size() != 0) {
    linB = places.get(places.size() - 1).y;
    colB = places.get(places.size() - 1).x;
  } else {
    linB = place.y;
    colB = place.x;
  }

  lin = place.y - 1;
  col = place.x;
  if (lin >= 0 && (maze[lin][col] == 0 || maze[lin][col] == 2) && (lin != linB || col != colB)) {
    Place newPlace = new Place();
    newPlace.x = col;
    newPlace.y = lin;
    place.places.add(newPlace);
  }

  lin = place.y + 1;
  col = place.x;
  if (lin < maze.length && (maze[lin][col] == 0 || maze[lin][col] == 2) && (lin != linB || col != colB)) {
    Place newPlace = new Place();
    newPlace.x = col;
    newPlace.y = lin;
    place.places.add(newPlace);
  }

  lin = place.y;
  col = place.x - 1;
  if (col >= 0 && (maze[lin][col] == 0 || maze[lin][col] == 2) && (lin != linB || col != colB)) {
    Place newPlace = new Place();
    newPlace.x = col;
    newPlace.y = lin;
    place.places.add(newPlace);
  }

  lin = place.y;
  col = place.x + 1;
  if (col <maze[0].length && (maze[lin][col] == 0 || maze[lin][col] == 2) && (lin != linB || col != colB)) {
    Place newPlace = new Place();
    newPlace.x = col;
    newPlace.y = lin;
    place.places.add(newPlace);
  }
}