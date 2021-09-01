class Simbolo {
  int token;
  String lexema;
  int linha, coluna;

  Simbolo(int token, String lexema, int linha, int coluna) {
    this.token = token;
    this.lexema = lexema;
    this.linha = linha;
    this.coluna = coluna;
  }

  Simbolo(String lexema, int linha, int coluna) {
    switch(lexema) {
    case "program":
      this.token = TK_PROGRAM;
      break;
    case "var":
      this.token = TK_VAR;
      break;
    case "integer":
      this.token = TK_INT;
      break;
    case "Begin":
      this.token = TK_BEGIN;
      break;
    case "read":
      this.token = TK_FUN_READ;
      break;
    case "write":
      this.token = TK_FUN_WRITE;
      break;
    case "loop":
      this.token = TK_LOOP;
      break;
    case "end":
      this.token = TK_END;
      break;
    case "goto":
      this.token = TK_GOTO;
      break;
    default:
      break;
    }
    
    this.lexema = lexema;
    this.linha = linha;
    this.coluna = coluna;
  }

  void printSimbolo() {
    println(token + ": " + lexema + " lin:" + linha + " col:" + coluna);
  }
}
