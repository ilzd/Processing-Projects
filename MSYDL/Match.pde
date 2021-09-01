class Match extends Activity {
  static final int SCREEN_OFFSET = 50, START_COUNTDOWN = 120;
  ArrayList<Enemy> enemies = new ArrayList();
  int difficulty = 1, time = 0, startCountDown = START_COUNTDOWN;
  int messageSize = 200;

  Match(int parent) {
    super(parent);
  }

  void update() {
  }
}





class ArcadeMatchActivity extends Match {
  SoundFile song = new SoundFile(MSYDL.this, "survive.wav");
  final static int ID = 6, 
    PREPARATION_TIME = 180, 
    LEVEL_DURATION = 900, 
    LEVEL_TYPES = 6;

  int prepTime;

  ArcadeMatchActivity(int parent) {
    super(parent);

    song.loop();
    song.play();

    loadLevel();
  }

  void loadLevel() {
    prepTime = PREPARATION_TIME;
    time = 0;

    resetPlayerState();

    enemies.clear();
    if ((difficulty - 1) % LEVEL_TYPES == 0) {
      for (int i = 0; i < 10; i++) {
        enemies.add(new BallEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 1) {
      for (int i = 0; i < 10; i++) {
        enemies.add(new StickEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 2) {
      for (int i = 0; i < 10; i++) {
        enemies.add(new BombEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 3) {
      for (int i = 0; i < 5; i++) {
        enemies.add(new BallEnemy());
      }
      for (int i = 0; i < 5; i++) {
        enemies.add(new StickEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 4) {
      for (int i = 0; i < 5; i++) {
        enemies.add(new StickEnemy());
      }
      for (int i = 0; i < 5; i++) {
        enemies.add(new BombEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 4) {
      for (int i = 0; i < 5; i++) {
        enemies.add(new BombEnemy());
      }
      for (int i = 0; i < 5; i++) {
        enemies.add(new BallEnemy());
      }
    } else if ((difficulty - 1) % LEVEL_TYPES == 5) {
      for (int i = 0; i < 3; i++) {
        enemies.add(new BallEnemy());
      }
      for (int i = 0; i < 3; i++) {
        enemies.add(new StickEnemy());
      }
      for (int i = 0; i < 3; i++) {
        enemies.add(new BombEnemy());
      }
      for (int i = 0; i < 1; i++) {
        enemies.add(new FollowingEnemy());
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).getHarder((difficulty - 1) * 3);
    }
  }

  void update() {
    if (startCountDown == 0) {
      display();
      if (prepTime == 0) {
        for (Enemy e : enemies) {
          e.update();
          for (Player p : players) {

            for (Point pt : p.getSteps()) {
              if (e.isColiding(pt.x, pt.y, p)) {
                p.active = false;
                if (checkGameState()) return;
              }
            }
          }
        }

        time++;
        if (LEVEL_DURATION == time) {
          difficulty += 1;
          loadLevel();
        }
      } else {
        prepTime--;
        fill(255);
        textSize(messageSize);
        text("LEVEL " + difficulty, 100, height / 2 + messageSize / 2);
      }
    } else {
      display();
      startCountDown--;
    }
    for (Player p : players) {
      if (p.active) {
        p.display();
      }
    }
  }

  boolean checkGameState() {
    int count = 0;
    for (Player p : players) {
      if (p.active) count++;
    }
    if (count == 0) {
      resetPlayerState();
      song.stop();
      startActivity(parent, ID);
    }

    return count == 0;
  }

  void display() {
    if (startCountDown == 0) {
      //background(30);
      noStroke();
      fill(30, 70);
      rect(0, 0, width, height);
      if (prepTime == 0) {
        fill(255);
        textSize(messageSize);
        text((LEVEL_DURATION - time) / 60 + 1, 100, height / 2 + messageSize / 2);
      }
    } else {
      background(0);
      noStroke();
      fill(120, 120, 190);
      rect(0, 0, map(startCountDown, START_COUNTDOWN, 0, 0, width), height);
    }
  }
}




class SurviveMatchActivity extends Match {
  SoundFile song = new SoundFile(MSYDL.this, "survive.wav");
  final static int ID = 5, 
    BALL_ENEMIES_AMOUNT = 3, 
    STICK_ENEMIES_AMOUNT = 2, 
    FOLLOWING_ENEMIES_AMOUNT = 1, 
    VANISHING_ENEMIES_AMOUNT = 1, 
    BOMB_ENEMIES_AMOUNT = 1, 
    INCREASE_DIFFICULTY_INTERVAL = 90, 
    RESPAWN_DURATION = 500;

  int[] respawns = new int[players.size()];

  SurviveMatchActivity(int parent) {
    super(parent);

    for (int i = 0; i < respawns.length; i++) {
      respawns[i] = 0;
    }

    song.loop();
    song.play();

    for (int i = 0; i < BALL_ENEMIES_AMOUNT; i++) {
      enemies.add(new BallEnemy());
    }
    for (int i = 0; i < STICK_ENEMIES_AMOUNT; i++) {
      enemies.add(new StickEnemy());
    }
    for (int i = 0; i < FOLLOWING_ENEMIES_AMOUNT; i++) {
      enemies.add(new FollowingEnemy());
    }
    for (int i = 0; i < VANISHING_ENEMIES_AMOUNT; i++) {
      enemies.add(new VanishingEnemy());
    }
    for (int i = 0; i < VANISHING_ENEMIES_AMOUNT; i++) {
      enemies.add(new BombEnemy());
    }
  }

  void update() {
    if (startCountDown == 0) {
      display();
      for (int i = 0; i < players.size(); i++) {
        Player p = players.get(i);

        for (Enemy e : enemies) {
          e.update();

          for (Point pt : p.getSteps()) {
            if (e.isColiding(pt.x, pt.y, p)) {
              p.active = false;
              if (checkGameState()) return;
            }
          }
        }
        if (!p.active) {
          respawns[i]++;
          if (respawns[i] >= RESPAWN_DURATION) {
            p.active = true;
            respawns[i] = 0;
          }
        }
      }

      time++;
      if (time % INCREASE_DIFFICULTY_INTERVAL == 0) {
        difficulty++;

        song.rate(1 + (float)difficulty / 140);

        manageDifficulty();
      }
    } else {
      display();
      startCountDown--;
    }
    for (int i = 0; i < players.size(); i++) {
      Player p = players.get(i);
      if (p.active) {
        p.display();
      } else {
        p.display((float)respawns[i] / RESPAWN_DURATION);
      }
    }
  }

  boolean checkGameState() {
    int count = 0;
    for (Player p : players) {
      if (p.active) count++;
    }
    if (count == 0) {
      resetPlayerState();
      song.stop();
      startActivity(parent, ID);
    }

    return count == 0;
  }

  void manageDifficulty() {
    if (difficulty % 1 == 0) {
      for (Enemy e : enemies) {
        e.getHarder(1);
      }
    }
  }

  void display() {
    if (startCountDown == 0) {
      background(30);
      fill(255);
      textSize(messageSize);
      text((time / 60), 100, height / 2 + messageSize / 2);
    } else {
      background(0);
      noStroke();
      fill(120, 120, 190, 100);
      rect(0, 0, map(startCountDown, START_COUNTDOWN, 0, 0, width), height);
    }
  }
}
