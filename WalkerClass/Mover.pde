class Mover {
  PVector location, velocity, acceleration;
  float mass, angle, angleVelocity = 0, angleAcceleration = 0;

  Mover(float px, float py, float m) {
    location = new PVector(px, py);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    mass = m;
  }

  void update() {
    velocity.add(acceleration);  
    location.add(velocity);


    angleAcceleration = acceleration.y / 500.0;
    angleVelocity += angleAcceleration;
    angle += angleVelocity;

    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(175);

    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);

    rect(0, 0, mass * 2, mass * 2);
    popMatrix();
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void checkEdges() {
    if (location.x + mass > width) {
      location.x = width - mass;
      velocity.x *= -1;
    } else if (location.x - mass < 0) {
      velocity.x *= -1;
      location.x = mass;
    }
    if (location.y + mass > height) {
      velocity.y *= -1;
      location.y = height - mass;
    } else if (location.y - mass < 0) {
      velocity.y *= -1;
      location.y = mass;
    }
  }

  boolean isInside(Liquid l) {
    if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h) {
      return true;
    } else {
      return false;
    }
  }

  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed; 
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
}
