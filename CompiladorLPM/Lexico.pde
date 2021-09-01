boolean analiseLexica(String cadeia) {
  int indice = 0, indiceAux = 0, linha = 1, coluna = 1;
  simbolos = new ArrayList();
  while (indice != -1 && indice < cadeia.length()) {
    char c = cadeia.charAt(indice);
    switch(c) {
    case ' ':
      coluna++;
      break;
    case '\n':
      linha++;
      coluna = 1;
      break;
    case '=':
      simbolos.add(new Simbolo(TK_ATR, "=", linha, coluna));
      coluna++;
      break;
    case ':':
      simbolos.add(new Simbolo(TK_DOIS_PONTOS, ":", linha, coluna));
      coluna++;
      break;
    case ';':
      simbolos.add(new Simbolo(TK_PONTO_E_VIRGULA, ";", linha, coluna));
      coluna++;
      break;
    case '+':
      simbolos.add(new Simbolo(TK_OP, "+", linha, coluna));
      coluna++;
      break;
    case '(':
      simbolos.add(new Simbolo(TK_ABRE_PAR, "(", linha, coluna));
      coluna++;
      break; 
    case ')':
      simbolos.add(new Simbolo(TK_FECHA_PAR, ")", linha, coluna));
      coluna++;
      break;
    case '0':
      simbolos.add(new Simbolo(TK_ZERO, "0", linha, coluna));
      coluna++;
      break;
    case '1':
      simbolos.add(new Simbolo(TK_UM, "1", linha, coluna));
      coluna++;
      break;
    default:
      indiceAux = palavra(cadeia, indice);
      if (indiceAux != -1) {
        String palavra = cadeia.substring(indice, indiceAux + 1);
        simbolos.add(new Simbolo(palavra, linha, coluna));
        coluna += palavra.length();
      }
      indice = indiceAux;
      break;
    }
    if (indice != -1) indice++;
  }

  if (indice == -1) {
    mensagem += "Analise léxica: Erro na palavra localizada na linha " + linha + " e na coluna " + coluna + "\n\n";
    return false;
  } else {
    simbolos.add(new Simbolo(TK_FIM, "$", linha, coluna));
    return true;
  }
}

int palavra(String cadeia, int indice) {
  char c = cadeia.charAt(indice);
  if (isLetter(c)) {
    return s1(cadeia, indice + 1);
  } else {
    return -1;
  }
}

int s1(String cadeia, int indice) {
  if (indice == cadeia.length()) return indice - 1;
  char c = cadeia.charAt(indice);
  if (isLetter(c) || isNumber(c)) {
    return s1(cadeia, indice + 1);
  } else {
    if (isSimbol(c)) {
      return indice - 1;
    } else {
      return -1;
    }
  }
}
