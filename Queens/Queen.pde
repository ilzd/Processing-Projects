class Queen {
  int x = 1, y = 1;

  boolean guards(int x, int y) {
    if (this.x == x || this.y == y || (modulo(this.x - x) == modulo(this.y - y))) {
      return true;
    } else {
      return false;
    }
  }
}