class Polygon {
  PShape s;
  PVector pos, vel;
  float rot, rotSpeed;

  Polygon(int faces, int size) {
    s = createShape();
    s.beginShape();
    s.strokeWeight(0.1);
    s.noFill();
    s.stroke(random(100, 255), random(100, 255), random(100, 255), 5);

    float angStep = TWO_PI / faces;
    for (int i = 0; i < faces; i++) {
      float ang = i * angStep;
      s.vertex(size * cos(ang), size * sin(ang));
    }
    s.endShape(CLOSE);

    pos = new PVector(random(0, width), random(0, height));
    vel = new PVector(random(-0.1, -0.05), random(-0.2, -0.05));
    rotSpeed = random(-0.002, -0.001);
  }

  void display() {
    pushMatrix(); 
    //translate(pos.x + noise(frameCount / 10.f) * 200, pos.y + noise(frameCount / 10.f) * 200);
    translate(pos.x, pos.y);
    rotate(rot);
    shape(s, 0, 0);
    popMatrix();
  }

  void move() {
    pos.x += vel.x;
    pos.y += vel.y;

    if (pos.x < 0) {
      vel.x *= -1;
    } else if (pos.x > width) {
      vel.x *= -1;
    }

    if (pos.y < 0) {
      vel.y *= -1;
    } else if (pos.y > height) {
      vel.y *= -1;
    }

    rot += rotSpeed;
  }
}
