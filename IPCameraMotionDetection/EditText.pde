class EditText {
  float x, y, w, h;
  String text;
  boolean active = false, pass;

  public EditText(float x, float y, float w, float h, String text, boolean pass) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.pass = pass;
  }

  void display() {
    fill(255);
    rect(x, y, w, h);
    fill(0);
    textSize(12);
    if (!pass) {
      text(text, x + 2, y + h - 2);
    } else {
      String passStr = "";
      for (int i = 0; i < text.length(); i++) {
        passStr += "*";
      }
      text(passStr, x + 2, y + h - 2);
    }
  }

  void updateActive() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      active = true;
      text = "";
    } else {
      active = false;
    }
  }

  void updateText(char keyP) {
    if (active)
      text += keyP;
  }
}
