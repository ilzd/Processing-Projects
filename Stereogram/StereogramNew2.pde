PImage[] depthMaps;
PImage stereogram;
int count = 0;

float ang = 0;

void setup() {
  //fullScreen();
  size(1366, 768);
  imageMode(CENTER);

  depthMaps = getHorSinMap(width, height, 1, 0.05);
}

void draw() {
  println(frameRate);
  image(getStereogram(depthMaps[count]), width / 2, height / 2);

  ang += PI / 25;

  count++;
  if (count == depthMaps.length) {
    count = 0;
  };
}
