final int 
  TK_ID = 0, 
  TK_OP = 1, 
  TK_ATR = 2, 
  TK_FUN_READ = 3, 
  TK_FUN_WRITE = 4, 
  TK_ABRE_PAR = 5, 
  TK_FECHA_PAR = 6, 
  TK_LOOP = 7, 
  TK_PONTO_E_VIRGULA = 8, 
  TK_DOIS_PONTOS = 9, 
  TK_END = 10, 
  TK_BEGIN = 11, 
  TK_PROGRAM = 12, 
  TK_VAR = 13, 
  TK_INT = 14, 
  TK_ZERO = 15, 
  TK_UM = 16, 
  TK_GOTO = 17, 
  TK_FIM = 18;

char[] simbolosAceitos = {'=', ';', ':', ')', '(', '+', ' ', '\n'};
String[] palavrasReservadas = {"program", "var", "integer", "Begin", "read", "write", "loop", "end", "goto"};

String cadeia, mensagem = "";
ArrayList<Simbolo> simbolos;

void setup() {
  size(800, 500);
}

void draw() {
  printInstructions();
}

void printInstructions() {
  textSize(16);
  background(0);
  fill(255);
  text("Coloque o código LPM no arquivo 'source.txt' localizado na pasta 'data'", 10, 26);
  text("Pressione qualquer tecla para iniciar ou repetir o processo de compilação", 10, 46);
  text(mensagem, 10, 100);
}

void keyPressed() {
  mensagem = "Processo de compilação iniciado:\n\n";
  leCadeia();
  boolean lexicaResult = analiseLexica(cadeia);
  mensagem += "Analise léxica: " + ((lexicaResult) ? "Ok" : "Falhou") + "\n\n";
  if (lexicaResult) {
    boolean sintaticaResult = analiseSintatica();
    mensagem += "Analise sintática: " + ((sintaticaResult) ? "Ok" : "Falhou") + "\n\n";

    if (sintaticaResult) {
      traduzir();
      mensagem += "Tradução de LPM para C realizada com sucesso\n\n";
      mensagem += "Arquivo 'output.'c gerado na pasta 'data'\n\n";
    }
  }
}

void leCadeia() {
  String[] linhas = loadStrings("source.txt");
  cadeia = "";
  for (int i = 0; i < linhas.length; i++) {
    cadeia += linhas[i];
    if (i != linhas.length - 1) cadeia += "\n";
  }
}

boolean isLetter(char c) {
  return (c >= 65 && c <= 90) || (c >= 97 && c <=  122);
}

boolean isNumber(char c) {
  return (c >= 48 && c <= 57);
}

boolean isSimbol(char c) {
  boolean result = false;
  for (int i = 0; i < simbolosAceitos.length; i++) {
    if (c == simbolosAceitos[i]) {
      result = true;
      break;
    }
  }
  return result;
}

boolean isReserved(String s) {
  boolean result = false;
  for (int i = 0; i < simbolosAceitos.length; i++) {
    if (s.equals(palavrasReservadas[i])) {
      result = true;
      break;
    }
  }
  return result;
}
