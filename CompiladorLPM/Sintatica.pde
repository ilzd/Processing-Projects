boolean foundError = false;

boolean analiseSintatica() {
  int count = 1;
  for (Simbolo s : simbolos) {
    if (s.token == TK_LOOP) {
      count++;
    } else if (s.token == TK_END) {
      count--;
    }
    if (count == -1) {
      mensagem += "Analise sintática: Instrução 'end;' indevida na linha " + s.linha + " e coluna " + s.coluna + "\n\n";
      return false;
    }
  }

  if (count != 0) {
    mensagem += "Faltando instruções 'end;'\n";
    return false;
  }

  if (simbolos.get(simbolos.size()-3).token != TK_END) {
    mensagem += "Não é permitido código após a intrução 'end;' que finaliza o programa\n\n";
    return false;
  }

  foundError = false;

  if (s1()) {
    return true;
  } else {
    return false;
  }
}

boolean s1() {
  if (simbolos.get(0).token == TK_PROGRAM && simbolos.get(1).token == TK_ID && simbolos.get(2).token == TK_PONTO_E_VIRGULA && simbolos.get(3).token == TK_VAR) {
    return s2(4);
  } else {
    if (!foundError) {
      mensagem += "Todo programa em LPM precisa começar com a estrutura:\n    program NOME_DO_PROGRAMA;\n    var\n\n";
      foundError = true;
    }
    return false;
  }
}

boolean s2(int i) {
  if (simbolos.get(i).token == TK_ID) {
    return s3(i+1);
  } else if (simbolos.get(i).token == TK_BEGIN) {
    return s4(i+1);
  } else {
    if (!foundError) {
      mensagem += "Após a palavra reservada 'var' é preciso iniciar com 'Begin' ou declarar variaveis com a sintaxe:\n    NOME_VARIAVEL:integer;\n\n";
      foundError = true;
    }
    return false;
  }
}

boolean s3(int i) {
  if (simbolos.get(i).token == TK_DOIS_PONTOS && simbolos.get(i+1).token == TK_INT && simbolos.get(i+2).token == TK_PONTO_E_VIRGULA) {
    return s2(i+3); // S2 VAI FAZER A VERIFICAÇÃO SE O PRÓXIMO ESTAGIO É DO BEGIN OU VOLTA A SER O PRÓPRIO VAR
  } else {
    if (!foundError) {
      mensagem += "Declaração incorreta de variável em linha " + simbolos.get(i).linha + " e coluna " + simbolos.get(i).coluna + "\n\n";
      foundError = true;
    }
    return false;
  }
}

boolean s4(int i) {
  if (simbolos.get(i).token == TK_FIM) {
    return true;
  }
  if (simbolos.get(i).token == TK_ID && simbolos.get(i+1).token == TK_ATR && simbolos.get(i+2).token == TK_ZERO && simbolos.get(i+3).token == TK_PONTO_E_VIRGULA) {
    return s4(i+4);
  } else if (simbolos.get(i).token == TK_ID && simbolos.get(i+1).token == TK_ATR && simbolos.get(i+2).token == TK_ID && simbolos.get(i+3).token == TK_OP && simbolos.get(i+4).token == TK_UM && simbolos.get(i+5).token == TK_PONTO_E_VIRGULA) {
    if (simbolos.get(i).lexema.equals(simbolos.get(i+2).lexema)) {
      return s4(i+6);
    } else {
      return false;
    }
  } else if (simbolos.get(i).token == TK_ID && simbolos.get(i+1).token == TK_ATR && simbolos.get(i+2).token == TK_ID && simbolos.get(i+3).token == TK_PONTO_E_VIRGULA) {
    return s4(i+4);
  } else if (simbolos.get(i).token == TK_FUN_READ && simbolos.get(i+1).token == TK_ABRE_PAR && simbolos.get(i+2).token == TK_ID && simbolos.get(i+3).token == TK_FECHA_PAR && simbolos.get(i+4).token == TK_PONTO_E_VIRGULA) {
    return s4(i+5);
  } else if (simbolos.get(i).token == TK_FUN_WRITE && simbolos.get(i+1).token == TK_ABRE_PAR && simbolos.get(i+2).token == TK_ID && simbolos.get(i+3).token == TK_FECHA_PAR && simbolos.get(i+4).token == TK_PONTO_E_VIRGULA) {
    return s4(i+5);
  } else if (simbolos.get(i).token == TK_LOOP && simbolos.get(i+1).token == TK_ID && simbolos.get(i+2).token == TK_PONTO_E_VIRGULA) {
    return s4(i+3);
  } else if (simbolos.get(i).token == TK_END && simbolos.get(i+1).token == TK_PONTO_E_VIRGULA) {
    return s4(i+2);
  } else {
    mensagem += "Instrução incorreta na linha " + simbolos.get(i).linha + " e coluna " + simbolos.get(i).coluna + "\n\n";
    return false;
  }
}
