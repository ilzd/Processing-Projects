void traduzir() {
  String codigo = "";
  int ident = 0;

  codigo += ident(ident) + "#include <stdio.h>\n\n";

  codigo += "void main(){\n";

  ident++;

  int i = 3;

  while (simbolos.get(i + 1).token != TK_BEGIN) {
    codigo += ident(ident) + "int " + simbolos.get(i + 1).lexema + ";\n";
    i += 4;
  }

  i += 2;

  while (simbolos.get(i).token != TK_FIM) {
    if (simbolos.get(i).token == TK_ID) {
      codigo += ident(ident);
      while (simbolos.get(i).token != TK_PONTO_E_VIRGULA) {
        codigo += simbolos.get(i).lexema;
        i++;
      }
      codigo += ";\n";
      i++;
    } else if (simbolos.get(i).token == TK_LOOP) {
      codigo += ident(ident) + "for(int INDICE_RESERVADO = 0; INDICE_RESERVADO < " + simbolos.get(i + 1).lexema + "; INDICE_RESERVADO++){\n";
      ident++;
      i += 3;
    } else if (simbolos.get(i).token == TK_END) {
      ident--;
      codigo += ident(ident) + "}\n";
      i += 2;
    } else if (simbolos.get(i).token == TK_FUN_READ) {
      codigo += ident(ident) + "scanf(" + (char)34 + "%d" + (char)34 + ", &" + simbolos.get(i + 2).lexema + ");\n";
      i += 5;
    } else if (simbolos.get(i).token == TK_FUN_WRITE) {
      codigo += ident(ident) + "printf(" + (char)34 + "%d" + (char)34 + ", " + simbolos.get(i + 2).lexema + ");\n";
      i += 5;
    } else {
      break;
    }
  }

  PrintWriter codigoOutput = createWriter("data/output.c");
  codigoOutput.print(codigo);
  codigoOutput.flush();
  codigoOutput.close();
}

String ident(int count) {
  String result = "";
  for (int i = 0; i < count; i++) {
    result += "  ";
  }
  return result;
}
