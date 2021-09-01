class Option {
  final static int SELECTION_DURATION = 100;
  String label;
  int posx, posy, w, h;
  int selectionStage = SELECTION_DURATION;
  color c;

  Option(String label, int x, int y, int w, int h, color c) {
    this.label = label;
    this.posx = x;
    this.posy = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }

  boolean updateSelection(float x_, float y_) {
    boolean result = false;
    if (y_ > posy && y_ < posy + h && x_ > posx && x_ < posx + w) {
      selectionStage--;
      if (selectionStage == 0) result = true;
    } else {
      selectionStage = SELECTION_DURATION;
    }
    return result;
  }

  void display() {
    strokeWeight(2);
    stroke(255);
    fill(c);
    rect(posx, posy, w, h);
    fill(100);
    rect(posx, posy, map(selectionStage, SELECTION_DURATION, 0, 0, w), h);
    fill(180, 220, 212);
    textSize(24);
    text(label, posx + 5, posy + 30);
  }
}

class MainMenuActivity extends Activity {
  final static int ID = 3;
  SoundFile song = new SoundFile(MSYDL.this, "menu.wav");

  MainMenuActivity(int parent) {
    super(parent);
    song.loop();
    song.play();
  }

  Option[] options = {
    new Option("SOBREVIVÊNCIA", minBoundX + 10, minBoundY + 10, 300, 100, 255 << 24 | 40 << 16 | 40 << 8 | 40), 
    new Option("ADICIONAR JOGADOR", maxBoundX - 310, minBoundY + 10, 300, 100, 255 << 24 | 40 << 16 | 40 << 8 | 40), 
    new Option("REMOVER JOGADOR", maxBoundX - 310, minBoundY + 140, 300, 100, 255 << 24 | 40 << 16 | 40 << 8 | 40), 
    new Option("ARCADE", minBoundX + 10, minBoundY + 140, 300, 100, 255 << 24 | 40 << 16 | 40 << 8 | 40)
  };

  void update() {
    display();
    for (int i = 0; i < options.length; i++) {
      options[i].display();
      if (options[i].updateSelection(mainPlayer.posx, mainPlayer.posy)) {
        selectOption(i);
      }
    }
    for (int i = 0; i < players.size(); i++) {
      players.get(i).display();
    }
  }

  void selectOption(int op) {
    switch(op) {
    case 0:
      song.stop();
      startActivity(SurviveMatchActivity.ID, ID);
      break;
    case 1:
      song.stop();
      startActivity(NewPlayerActivity.ID, ID);
      break;
    case 2:
      song.stop();
      startActivity(RemovePlayerActivity.ID, ID);
      break;
    case 3:
      song.stop();
      startActivity(ArcadeMatchActivity.ID, ID);
      break;
    }
  }

  void display() {
    background(90, 20, 90);
  }
}
