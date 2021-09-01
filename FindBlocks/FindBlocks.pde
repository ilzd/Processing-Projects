int lin = 0, col = 0, linAux = 0, colAux = 0;
float size;
boolean discoveringBlock = false;
ArrayList<Block> blocks = new ArrayList();
ArrayList<Place> places = new ArrayList();

int[][] matrix = { 
  {0, 0, 0, 0, 0, 0, 0, 1, 1, 0}, 
  {0, 1, 1, 1, 0, 1, 0, 1, 1, 0}, 
  {0, 1, 1, 1, 0, 1, 0, 0, 1, 1}, 
  {0, 1, 0, 0, 0, 1, 1, 1, 0, 0}, 
  {0, 0, 0, 1, 0, 0, 1, 1, 0, 0}, 
  {1, 1, 1, 1, 1, 1, 0, 0, 0, 0}, 
  {1, 0, 0, 0, 0, 1, 0, 1, 1, 0}, 
  {1, 1, 1, 1, 0, 1, 0, 1, 1, 0}, 
  {1, 0, 0, 0, 0, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 0}};

void setup() {
  size(500, 500);
  frameRate(12);
  size = width / matrix.length;
}

void draw() {
  background(0);

  drawMatrix();

  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).display();
  }

  if (!discoveringBlock) {
    findBlocks();
  } else {
    discoverBlock();
  }

  if (lin < matrix.length) {
    stroke(255);
    strokeWeight(1);
    fill(255);
    rect(linAux * size, colAux * size, size, size);
  }
}

void drawMatrix() {
  stroke(255);
  strokeWeight(1);
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[0].length; j++) {
      if (matrix[i][j] == 0) {
        fill(20);
      } else {
        fill(90);
      }
      rect(j * size, i * size, size, size);
    }
  }
}

void findBlocks() {  
  if (lin < matrix.length) {
    col++;
    if (col == matrix.length) {
      col = 0;
      lin++;
    }
    linAux = lin;
    colAux = col;

    if (lin < matrix.length && col < matrix[0].length) {
      if (matrix[col][lin] == 1) {
        discoveringBlock = true;
        Block block = new Block(size);
        blocks.add(block);
        Place place = new Place(col, lin);
        places.add(place);
      }
    }
  }
}


void discoverBlock() {
  if (places.size() != 0) {
    Place place = places.get(0);
    places.remove(0);

    stroke(255);
    strokeWeight(1);
    fill(255, 200);
    rect(place.col * size, place.lin * size, size, size);

    blocks.get(blocks.size() - 1).places.add(place);
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if ((place.lin + i >= 0 && place.lin + i < matrix.length) && (place.col + j >= 0 && place.col + j < matrix[0].length) && ((i == 0 && j != 0) || (i != 0 && j == 0))) {
          if (matrix[place.lin + i][place.col + j] == 1) {
            Place newPlace = new Place(place.lin + i, place.col + j);
            matrix[newPlace.lin][newPlace.col] = 2;
            places.add(newPlace);
          }
        }
      }
    }
  } else {
    discoveringBlock = false;
  }
}