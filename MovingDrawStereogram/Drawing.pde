class Drawing {
  float Body[][], BodyPos[][];
  color col = color(random(255), random(255), random(255));
  int age = 0;

  Drawing(ArrayList<float[]> pos) {
    Body = new float[pos.size()][2]; 
    BodyPos = new float[pos.size()][2];
    float[] aux = new float[4];
    for (int i = 0; i < pos.size(); i++) {
      aux = pos.get(i);
      BodyPos[i][0] = aux[0];
      BodyPos[i][1] = aux[1];
      Body[i][0] = aux[2];
      Body[i][1] = aux[3];
    }
  }

  void move() {
    for (int i = 0; i < Body.length - 1; i++) {
      BodyPos[i][0] += Body[i + 1][0];  
      BodyPos[i][1] += Body[i + 1][1];
    }

    float[] aux = new float[2];
    aux[0] = BodyPos[BodyPos.length - 1][0];
    aux[1] = BodyPos[BodyPos.length - 1][1];

    for (int i = Body.length - 1; i > 0; i--) {
      BodyPos[i][0] = BodyPos[i - 1][0]; 
      BodyPos[i][1] = BodyPos[i - 1][1];
    }

    BodyPos[0][0] = aux[0];
    BodyPos[0][1] = aux[1];
    age++;
  }

  void display() {
    //stroke(col);
    //colorMode(HSB, Body.length - 1, Body.length - 1, Body.length - 1);  
    for (int i = 0; i < Body.length - 1; i++) {
      //strokeWeight(map(i, 0, Body.length - 1, 0, 6));
      //stroke(Body.length - 1 - (i + age)%Body.length, Body.length - 1, Body.length - 1);
      strokeWeight(map(i, 0, Body.length - 1, 0, 50));
      stroke(map(i, 0, Body.length, 0, 255));
      line(BodyPos[(int)(i + age)%Body.length][0], BodyPos[(int)(i + age)%Body.length][1], BodyPos[(int)(i + age + 1)%Body.length][0], BodyPos[(int)(i + age + 1)%Body.length][1]);
    }
  }
}
