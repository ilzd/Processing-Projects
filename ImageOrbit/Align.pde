class AlignEffect {
  ImagePhys[] imageP;
  float ang = 1, speed;

  public AlignEffect(PImage image, int cols, int rows) {
    float middleX = image.width / 2;
    float middleY = image.height / 2;
    int wid = image.width / cols;
    int hei = image.height / rows;

    this.imageP = new ImagePhys[cols * rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        PImage aux = createImage(wid, hei, RGB);
        aux.copy(image, i * wid, j * hei, wid, hei, 0, 0, wid, hei);
        imageP[j * cols + i] = new ImagePhys(aux, i * wid - middleX, j * hei - middleY, 200, 0, rows - j, wid, hei);
      }
    }
  }

  void update() {
    display();
    execute();
  }


  void execute() {
    speed = map(distToPower(ang, TWO_PI, 0.7), TWO_PI, 0, 0.007, 0.001);
    ang += speed / (frameRate / 60);
    if (ang >= TWO_PI * 2) ang = 0;
  }

  void display() {
    translate(width / 2, height / 2);

    fill(0, 30);
    pushMatrix();
    translate(0, 0, -1000);
    rect(-width * 2, -height * 2, width * 4, height * 4);
    popMatrix();

    rotateY(ang);
    rotateX(ang);
    rotateZ(ang);

    for (int i = 0; i < imageP.length; i++) {
      pushMatrix();
      rotateX(imageP[i].angX * ang);
      rotateY(imageP[i].angY * ang);
      translate(0, 0, imageP[i].z);
      image(imageP[i].img, imageP[i].x, imageP[i].y);
      popMatrix();
    }
  }
}

class ImagePhys {
  float x, y, z, w, h; 
  float angX, angY;
  PImage img;

  public ImagePhys(PImage img, float x, float y, float z, float angX, float angY, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.angX = angX;
    this.angY = angY;
    this.img = img;
    this.h = h;
    this.w = w;
  }
}
