class NewPlayerActivity extends Activity {
  final static int ID = 2, 
    TRACKING_DURATION = 200, 
    TRACKER_DIAMETER_MIN = 25, 
    TRACKER_DIAMETER_MAX = 450;

  int trackingCountDown = TRACKING_DURATION;

  PImage img;

  NewPlayerActivity(int parent) {
    super(parent);
  }

  void update() {
    drawTracker();
    trackingCountDown--;
    if (trackingCountDown == 0) {
      players.add(new Player(width / 2, height / 2, getColorInCenter(), players.size()));
      startActivity(VerifyPlayerActivity.ID, parent);
    }
  }

  color getColorInCenter() {
    int r = 0, g = 0, b = 0, count = 0;
    for (int y = -TRACKER_DIAMETER_MIN; y <= TRACKER_DIAMETER_MIN + 1; y++) {
      int value = (int)sqrt(pow(TRACKER_DIAMETER_MIN / 2, 2) - pow(y, 2));
      for (int x = -value; x < value; x++) {
        color c = img.pixels[img.width * (img.height / 2 + y) + img.width / 2 + x];
        r += (c >> 16) & 0xFF;
        g += (c >> 8) & 0xFF;
        b += c & 0xFF;
        count++;
      }
    }

    r /= count;
    g /= count;
    b /= count;

    return 255 << 24 | r << 16 | g << 8 | b;
  }

  void drawTracker() {
    background(0);
    img = frame.copy();
    if (frame.width > 0) img.resize((int)(frame.width * 1.5), (int)(img.height * 1.5));
    image(img, width / 2 - img.width / 2, height / 2 - img.height / 2);
    stroke(255, 0, 0); 
    strokeWeight(4); 
    noFill(); 
    ellipse(width / 2, height / 2, TRACKER_DIAMETER_MIN, TRACKER_DIAMETER_MIN);
    stroke(0, 0, 255);
    float trackerPosition = map(trackingCountDown, TRACKING_DURATION, 0, TRACKER_DIAMETER_MAX, TRACKER_DIAMETER_MIN); 
    ellipse(width / 2, height / 2, trackerPosition, trackerPosition);
  }
}





class VerifyPlayerActivity extends Activity {
  static final int ID = 7, 
    VERIFYING_DURATION = 500, 
    VERIFYING_STAGES = 50, 
    STATE_TRACKING = 1, 
    STATE_VERIFYING = 2;

  int verifyingCountDown = VERIFYING_DURATION, verifyingStage = VERIFYING_STAGES;

  VerifyPlayerActivity(int parent) {
    super(parent);
  }

  void update() {
    if (verifyingCountDown > 0) {
      verifyPlayer();
      verifyingCountDown--;
      if (verifyingStage == 0) {
        if (players.size() == 1) mainPlayer = players.get(0);
        startActivity(parent, ID);
      }
    } else {
      players.remove(players.size() - 1);
      startActivity(parent, ID);
    }
  }

  void verifyPlayer() {
    int playerIndex = players.size() - 1;
    Player p = players.get(playerIndex);

    background(0);
    fill(0, 255, 0, 50);
    noStroke();
    rect(0, 0, map(verifyingCountDown, VERIFYING_DURATION, 1, 0, width), height);

    noFill();
    stroke(0, 255, 0);
    strokeWeight(4);
    float posX = map(verifyingStage, VERIFYING_STAGES, 1, width * 0.2, width * 0.8);
    float posY = height / 2;
    float radius = Player.BASE_RADIUS * 3;
    ellipse(posX, posY, radius * 2, radius * 2);

    p.display();

    for (int i = 0; i < p.blobs.size(); i++) {
      float maxDist = radius - Player.BASE_RADIUS;
      if (distSq(posX, posY, p.posx, p.posy) < maxDist * maxDist) {
        verifyingStage--;
        break;
      }
    }
  }
}




class RemovePlayerActivity extends Activity {
  final static int ID = 4;
  ArrayList<Option> options = new ArrayList();

  RemovePlayerActivity(int parent) {
    super(parent);
    options.add(new Option("CANCELAR", maxBoundX - 310, maxBoundY - 110, 300, 100, 255<<24|0<<16|0<<8|0));
    for (int i = 1; i < players.size(); i++) {
      options.add(new Option("Remover JOGADOR " + (i + 1), minBoundX + 10, minBoundY + 10 + (110 * (i - 1)), 300, 100, players.get(i).trackColor));
    }
  }

  void update() {
    display();
    for (int i = 0; i < options.size(); i++) {
      options.get(i).display();
      if (options.get(i).updateSelection(mainPlayer.posx, mainPlayer.posy)) {
        selectOption(i);
      }
    }
    players.get(0).display();
  }

  void selectOption(int op) {
    if (op != 0) {
      players.remove(op);
    }
    startActivity(parent, ID);
  }

  void display() {
    background(180, 100, 100);
  }
}
