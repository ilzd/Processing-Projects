class FirstActivity extends Activity {
  final static int ID = 1; //ID DE IDENTIFICAÇÃO DA ATIVIDADE

  FirstActivity(int parent) {
    super(parent);
  }

  void update() {
    if (players.size() > 0) {
      startActivity(MainMenuActivity.ID, ID);
    } else {
      startActivity(NewPlayerActivity.ID, ID);
    }
  }
}
