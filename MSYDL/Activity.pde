abstract class Activity {
  int parent; //Atividade PAI, que iniciou a atividade atual.

  Activity(int parent) {
    this.parent = parent;
  }

  abstract void update(); //Método abstrato que toda atividade precisa ter
}

void startActivity(int activityId, int parent) {
  switch(activityId) {
  case FirstActivity.ID:
    act = new FirstActivity(parent);
    break;
  case NewPlayerActivity.ID: 
    act = new NewPlayerActivity(parent);
    break;
  case MainMenuActivity.ID:
    act = new MainMenuActivity(parent);
    break;
  case RemovePlayerActivity.ID:
    act = new RemovePlayerActivity(parent);
    break;
  case SurviveMatchActivity.ID:
    act = new SurviveMatchActivity(parent);
    break;
  case ArcadeMatchActivity.ID:
    act = new ArcadeMatchActivity(parent);
    break;
  case VerifyPlayerActivity.ID:
    act = new VerifyPlayerActivity(parent);
    break;
  default:
    break;
  }
}
