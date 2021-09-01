class Block {
  ArrayList<Place> places = new ArrayList();
  color c = color(random(50, 225), random(50, 225), random(50, 225));
  float size;

  Block(float size) {
    this.size = size;
  }

  void display() {
    strokeWeight(1);
    stroke(255);
    fill(c);
    for (int i = 0; i < places.size(); i++) {
      Place place = places.get(i);
      rect(place.col * size, place.lin * size, size, size);
    }
  }
}