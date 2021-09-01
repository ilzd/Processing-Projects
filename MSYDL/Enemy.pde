abstract class Enemy {
  float posx, posy, speed;
  PVector dir;

  Enemy() {
    this.posx = random(0, width);
    this.posy = random(0, height);
    this.dir = new PVector(random(-1, 1), random(-1, 1)).normalize();
    float aux = random(0, 4);

    if (aux < 1) {
      posx = -Match.SCREEN_OFFSET;
    } else if (aux < 2) {
      posy = -Match.SCREEN_OFFSET;
    } else if (aux < 3) {
      posx = width + Match.SCREEN_OFFSET;
    } else {
      posy = height + Match.SCREEN_OFFSET;
    }
  }

  abstract void update();

  abstract boolean isColiding(float x, float y, Player p);

  abstract void getHarder(int levels);
}




//CLASSE QUE DEFINE O INIMIGO BOLA NORMAL
class BallEnemy extends Enemy {
  final static float SPEED_PER_DIFFICULTY = 0.10, 
    RADIUS_PER_DIFFICULTY = 0.2, 
    BASE_SPEED = 3, 
    BASE_RADIUS = 40;
  float radius;

  BallEnemy() {
    this.speed = BASE_SPEED;
    this.radius = BASE_RADIUS;
  }

  void update() {
    move();
    display();
  }

  void getHarder(int levels) {
    speed += SPEED_PER_DIFFICULTY * levels;
    radius += RADIUS_PER_DIFFICULTY * levels;
  }

  void move() {
    posx += dir.x * speed;
    posy += dir.y * speed;

    if (posx < -Match.SCREEN_OFFSET || posx > width + Match.SCREEN_OFFSET) {
      dir.x *= -1;
    }

    if (posy < -Match.SCREEN_OFFSET || posy > height + Match.SCREEN_OFFSET) {
      dir.y *= -1;
    }
  }

  boolean isColiding(float x, float y, Player p) {
    float minDist = pow(p.radius + radius, 2);
    return distSq(x, y, posx, posy) < minDist;
  }

  void display() {
    noStroke();
    fill(255, 119, 0);
    ellipse(posx, posy, radius * 2, radius * 2);
  }
}

class StickEnemy extends Enemy {
  final static float SPEED_PER_DIFFICULTY = 0.1, 
    SIZE_PER_DIFFICULTY = 5, 
    THICKNESS_PER_DIFFICULTY = 0, 
    SPIN_SPEED_PER_DIFFICULTY = PI / 4200, 
    BASE_SPEED = 1.5, 
    BASE_SIZE = 220, 
    BASE_THICKNESS = 10, 
    BASE_SPIN_SPEED = PI / 840;
  float thickness, size, spinSpeed, angle;
  float xi, yi, xf, yf;

  StickEnemy() {
    this.speed = BASE_SPEED;
    this.size = BASE_SIZE;
    this.thickness = BASE_THICKNESS;
    this.spinSpeed = BASE_SPIN_SPEED;
    angle = random(0, PI);
  }

  void update() {
    move();
    display();
  }

  void getHarder(int levels) {
    this.speed += SPEED_PER_DIFFICULTY * levels;
    this.size += SIZE_PER_DIFFICULTY * levels;
    this.thickness += THICKNESS_PER_DIFFICULTY * levels;
    this.spinSpeed += SPIN_SPEED_PER_DIFFICULTY * levels;
  }

  void move() {
    posx += dir.x * speed;
    posy += dir.y * speed;
    angle += spinSpeed;

    xi = posx - cos(angle) * (size / 2);
    xf = posx + cos(angle) * (size / 2);
    yi = posy - sin(angle) * (size / 2);
    yf = posy + sin(angle) * (size / 2);

    if (posx < -Match.SCREEN_OFFSET || posx > width + Match.SCREEN_OFFSET) {
      dir.x *= -1;
    }

    if (posy < -Match.SCREEN_OFFSET || posy > height + Match.SCREEN_OFFSET) {
      dir.y *= -1;
    }
  }

  boolean isColiding(float x, float y, Player p) {
    float minDist = pow(p.radius, 2);
    PVector AB = new PVector(xf - xi, yf - yi);
    PVector AC = new PVector(x - xi, y - yi);

    if ((AC.mag() + p.radius) / AB.mag() > 1) return false;

    if (AB.dot(AC) < 0) return distSq(xi, yi, x, y) < minDist;

    PVector BA = new PVector(xi - xf, yi - yf);
    PVector BC = new PVector(x - xf, y - yf);

    if (BA.dot(BC) < 0) return distSq(xf, yf, x, y) < minDist;

    float k = AB.dot(AC) / AB.magSq();
    PVector w = new PVector(k * AB.x, k * AB.y);

    return distSq(w.x, w.y, AC.x, AC.y) < minDist;
  }

  void display() {
    stroke(255, 0, 255);
    strokeWeight(thickness);
    line(xi, yi, xf, yf);
  }
}




//CLASSE QUE DEFINE O INIMIGO QUE FICA PERSEGUINDO O JOGADOR MAIS PRÓXIMO
class FollowingEnemy extends Enemy {
  final static float SPEED_PER_DIFFICULTY = 0.05, 
    RADIUS_PER_DIFFICULTY = 0, 
    BASE_SPEED = 1, 
    BASE_RADIUS = 20;
  float radius;

  FollowingEnemy() {
    this.speed = BASE_SPEED;
    this.radius = BASE_RADIUS;
  }

  void update() {
    move();
    display();
  }

  void getHarder(int levels) {
    speed += SPEED_PER_DIFFICULTY * levels;
    radius += RADIUS_PER_DIFFICULTY * levels;
  }

  void move() {
    float minDist = 999999999;
    int index = -1;

    for (int i = 0; i < players.size(); i++) {
      Player p = players.get(i);
      if (p.active) {
        float dist = distSq(p.posx, p.posy, posx, posy);
        if (dist < minDist) {
          index = i;
          minDist = dist;
        }
      }
    }

    Player p2 = players.get(index);
    dir = new PVector(p2.posx - posx, p2.posy - posy).normalize();

    posx += dir.x * speed;
    posy += dir.y * speed;
  }

  boolean isColiding(float x, float y, Player p) {
    float minDist = pow(p.radius + radius, 2);
    return distSq(x, y, posx, posy) < minDist;
  }

  void display() {
    noStroke();
    fill(119, 119, 255);
    ellipse(posx, posy, radius * 2, radius * 2);
  }
}




//CLASSE QUE DEFINE O INIMIGO QUE VAI FICANO INVISÍVEL
class VanishingEnemy extends Enemy {
  final static float SPEED_PER_DIFFICULTY = 0.10, 
    RADIUS_PER_DIFFICULTY = 0.2, 
    BASE_SPEED = 2.5, 
    BASE_RADIUS = 30, 
    BASE_VISIBILITY = 100;
  float radius, visibility;

  VanishingEnemy() {
    this.speed = BASE_SPEED;
    this.radius = BASE_RADIUS;
    this.visibility = BASE_VISIBILITY;
  }

  void update() {
    move();
    display();
  }

  void getHarder(int levels) {
    speed += SPEED_PER_DIFFICULTY * levels;
    radius += RADIUS_PER_DIFFICULTY * levels;
  }

  void move() {
    posx += dir.x * speed;
    posy += dir.y * speed;
    visibility += speed * -0.08;

    if (posx < -Match.SCREEN_OFFSET || posx > width + Match.SCREEN_OFFSET) {
      dir.x *= -1;
      visibility = BASE_VISIBILITY;
    }

    if (posy < -Match.SCREEN_OFFSET || posy > height + Match.SCREEN_OFFSET) {
      dir.y *= -1;
      visibility = BASE_VISIBILITY;
    }
  }

  boolean isColiding(float x, float y, Player p) {
    float minDist = pow(p.radius + radius, 2);
    return distSq(x, y, posx, posy) < minDist;
  }

  void display() {
    noStroke();
    float vis = max(0, map(visibility, 200, 20, 255, 0));
    fill(255, 0, 0, vis);
    ellipse(posx, posy, radius * 2, radius * 2);
  }
}



class BombEnemy extends Enemy {
  private final int BASE_EXPLOSION_RADIUS = 300, 
    BASE_EXPLOSION_TIMER = 540, 
    BASE_RADIUS = 40, 
    BASE_EXPLOSION_STAGES = 120, 
    EXPLOSION_RADIUS_PER_DIFFICULTY = 10, 
    RADIUS_PER_DIFFICULTY = 0;
  private final float EXPLOSION_TIMER_MULTIPLIER_PER_DIFFICULTY = 0.95, 
    EXPLOSION_STAGES_MULTIPLIER_PER_DIFFICULTY = 0.95;

  int difficulty = 0;
  float radius, explosionRadius, maxExplosionRadius, explosionTimer, maxExplosionTimer, explosionStages;

  BombEnemy() {
    reset();
  }

  void reset() {
    this.posx = random(minBoundX, maxBoundX);
    this.posy = random(minBoundY, maxBoundY);

    this.radius = BASE_RADIUS + RADIUS_PER_DIFFICULTY * difficulty;
    this.maxExplosionRadius = BASE_EXPLOSION_RADIUS + EXPLOSION_RADIUS_PER_DIFFICULTY * difficulty;
    this.explosionRadius = 0;
    this.explosionTimer = BASE_EXPLOSION_TIMER;
    for (int i = 0; i < difficulty; i++) {
      this.explosionTimer *= EXPLOSION_TIMER_MULTIPLIER_PER_DIFFICULTY;
    }
    this.maxExplosionTimer = explosionTimer;
    this.explosionStages = BASE_EXPLOSION_STAGES;
    for (int i = 0; i < difficulty; i++) {
      this.explosionStages *= EXPLOSION_STAGES_MULTIPLIER_PER_DIFFICULTY;
    }
  }

  boolean isColiding(float x, float y, Player p) {
    float minDist;
    if (explosionTimer < 0) {
      minDist = pow(p.radius + explosionRadius, 2);
      return distSq(x, y, posx, posy) < minDist;
    } else {
      minDist = pow(p.radius + radius, 2);
      if (distSq(x, y, posx, posy) < minDist && p.active)reset();
      return false;
    }
  }

  void update() {
    explosionTimer--;
    if (explosionTimer < -explosionStages) {
      reset();
    }
    display();
  }

  void getHarder(int levels) {
    difficulty += levels;
  }

  void display() {
    strokeWeight(2);
    stroke(127, 0, 255);
    fill(127, 0, 255);
    float rad;
    if (explosionTimer > 0) {
      rad = map(explosionTimer, maxExplosionTimer, 0, 0, radius);
      ellipse(posx, posy, rad * 2, rad * 2);
      noFill();
      ellipse(posx, posy, radius * 2, radius * 2);
    } else {
      explosionRadius = map(explosionTimer, 0, -explosionStages, 0, maxExplosionRadius);
      ellipse(posx, posy, explosionRadius * 2, explosionRadius * 2);
    }
  }
}
