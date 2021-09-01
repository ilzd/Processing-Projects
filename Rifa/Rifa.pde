int count = 1, perPage = 25, pages = 50;

String headerText = "Rifa-se uma CESTA DE CAFÉ DA MANHÃ com o objetivo de arrecadar fundos para a fundação da ONG Pelo Amor. A Pelo Amor tem como objetivo proteger e resgatar animais abandonados de rua, fazendo a castração e colocando-os para adoção, diminuindo assim a alta população desses animais nas ruas da cidade de Atílio Vivacqua-ES.\n\nVALOR: R$ 1,00\nDATA DO SORTEIO: 01/03/2020";

void setup() {
  size(2480, 3508);
  fill(0);

  for (int i = 0; i < pages; i++) {
    background(255);
    textSize(60);
    textAlign(CENTER);
    text("AÇÃO ENTRE AMIGOS", width / 2, 120);
    textAlign(LEFT);
    textSize(45);
    text(headerText, width * 0.05, 170, width * 0.9, 500);

    textAlign(LEFT, BOTTOM);
    text("Nº", width * 0.07, 720);
    text("NOME", width * 0.17, 720);
    text("TELEFONE", width * 0.72, 720);

    int h = (height - 820) / perPage;
    noFill();
    strokeWeight(2);
    textAlign(CENTER, CENTER);
    for (int j = 0; j < perPage; j++) {
      rect(width * 0.05, 740 + h * j, width * 0.9, h);
      line(width * 0.15, 740 + h * j, width * 0.15, 740 + h * (j + 1));
      line(width * 0.7, 740 + h * j, width * 0.7, 740 + h * (j + 1));
      text(count, width * 0.1, 740 + h * j + h / 2);
      count++;
    }

    save("rifa" + i + ".png");
  }
}

void draw() {
}
