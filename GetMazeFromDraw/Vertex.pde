class Vertex {
  int lin, col, dist;
  Vertex bestVertex = null;
  boolean visitable, close, destiny = false, visited = false, origin = false;

  Vertex(int lin, int col, boolean visitable, int dist) {
    this.lin = lin;
    this.col = col;
    this.visitable = visitable;
    this.dist = dist;
  }
}