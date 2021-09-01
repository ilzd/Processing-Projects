class Ball {
  static final int MAX_SPEED = 5; 
  float px, py;
  int surviveTime, radius;
  boolean dead;
  Sensor[] sensors;
  Net net;

  Ball() {

    sensors = new Sensor[12];
    float sensorAng;
    for (int i = 0; i < sensors.length; i++) {
      sensorAng = map(i, 0, sensors.length, 0, TWO_PI);
      sensors[i] = new Sensor(sensorAng);
    }

    net = new Net(new int[] {sensors.length, 15, 4}, 0, 0, 0.1);

    reset();
  }

  void reset() {
    px = width / 2;
    py = height / 2;
    radius = 20;
    dead = false;
    surviveTime = 0;
  }

  void update() {
    surviveTime++;

    for (Sensor s : sensors) {
      s.readValue(px, py);
      if (s.value < radius) dead = true;
    }

    float[] sensorValues = new float[sensors.length];
    for (int i = 0; i < sensors.length; i++) {
      //sensorValues[i] = map(sensors[i].value, 0, Sensor.MAX_VALUE, 1, 0);
      sensorValues[i] = sensors[i].value;
    }

    float[]decision = net.solve(sensorValues);

    //direita(decision[0]);
    //esquerda(decision[1]);
    //cima(decision[2]);
    //baixo(decision[3]);
    if (decision[0] > 0.5) direita(1);
    if (decision[1] > 0.5) esquerda(1);
    if (decision[2] > 0.5) cima(1);
    if (decision[3] > 0.5) baixo(1);
  }

  void display() {
    for (Sensor s : sensors) {
      s.display(px, py);
    }

    fill(0, 255, 0);
    ellipse(px, py, radius * 2, radius * 2);
  }

  void direita(float spd) {
    px += MAX_SPEED * spd;
  }

  void esquerda(float spd) {
    px -= MAX_SPEED * spd;
  }

  void cima(float spd) {
    py -= MAX_SPEED * spd;
  }

  void baixo(float spd) {
    py += MAX_SPEED * spd;
  }
}

class Sensor {
  static final int MAX_VALUE = 200;
  float ang;
  int value;

  Sensor(float ang) {
    this.ang = ang;
  }

  void display(float x, float y) {
    line(x, y, x + cos(ang) * value, y + sin(ang) * value);
  }

  void readValue(float x, float y) {
    int dist = 0;
    boolean collided = false;
    float px, py;
    while (!collided) {
      dist += 3;
      px = x + cos(ang) * dist;
      py = y + sin(ang) * dist;
      //if (px <= 0 || px >= width || py <= 0 || py >= height || dist >= MAX_VALUE) {
      if (px <= 0 || px >= width || py <= 0 || py >= height) {
        collided = true;
        break;
      }

      for (Enemy e : enemies) {
        if (dist(px, py, e.px, e.py) < e.radius) {
          collided = true;
          break;
        }
      }
    }
    value = dist;
  }
}
