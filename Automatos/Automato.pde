class Automato {
  static final int ATIV_ESTADOS = 1, ATIV_RELACOES = 2, ATIV_TESTE = 3;
  ArrayList<Estado> estados = new ArrayList();
  ArrayList<Relacao> relacoes = new ArrayList();
  ArrayList<Character> cadeiaTeste = new ArrayList(), cadeiaTestada = new ArrayList();
  int atividade = 1, aux;
  Estado aux1, aux2;

  boolean trocaAtividade(int tecla) {
    boolean result = true;
    int ativ = 0;
    switch(tecla) {
    case '1':
      ativ = ATIV_ESTADOS;
      break;
    case '2':
      ativ = ATIV_RELACOES;
      break;
    case '3':
      ativ = ATIV_TESTE;
      break;
    default:
      result = false;
      break;
    }

    if (result) {
      reseta();
      atividade = ativ;
    }
    return result;
  }

  void testaCadeia() {
    if (aux == 0) {
      for (Estado e : estados) {
        if (e.ini) {
          aux1 = e;
          aux1.sel = true;
          for (Estado es : estados) {
            if (es.fin) {
              aux = 1;
              break;
            }
          }
          break;
        }
      }
      if (aux == 0) aux = 4;
    } else if (aux == 1) {
      if (cadeiaTeste.size() > 0) {
        char c = cadeiaTeste.get(0);
        boolean found = false;
        for (Relacao rel : relacoes) {
          if (rel.origem == aux1) {
            for (char ch : rel.caracteres) {
              if (c == ch) {
                found = true;
                aux1.sel = false;
                aux1 = rel.destino;
                aux1.sel = true;
                cadeiaTestada.add(c);
                cadeiaTeste.remove(0);
              }
            }
          }
          if (found) break;
        }
        if (!found) aux = 2;
      } else {
        if (aux1.fin) {
          aux = 3;
        } else {
          aux = 2;
        }
      }
    }
  }

  void reseta() {
    if (atividade == ATIV_RELACOES) {
      if (aux == 2) relacoes.remove(relacoes.size() - 1);
    }

    aux = 0;
    if (aux1 != null) {
      aux1.sel = false;
      aux1 = null;
    }
    if (aux2 != null) {
      aux2.sel = false;
      aux2 = null;
    }

    for (int i = cadeiaTestada.size() - 1; i >= 0; i--) {
      cadeiaTeste.add(0, cadeiaTestada.get(i));
    }
    cadeiaTestada.clear();
  }

  void adicionaEstado(int x, int y) {
    estados.add(new Estado(x, y));
  }

  void removeEstado(int x, int y) {
    int estado = pegaEstado(x, y);
    if (estado != -1) { 
      Estado e = estados.get(estado);
      for (int i = relacoes.size() - 1; i >= 0; i--) {
        Relacao rel = relacoes.get(i);
        if (rel.origem == e || rel.destino == e) {
          relacoes.remove(i);
        }
      }
      estados.remove(estado);
    }
  }

  void removeRelacao(int x, int y) {
    int relacao = pegaRelacao(x, y);
    if (relacao != -1) relacoes.remove(relacao);
  }

  int pegaRelacao(int x, int y) {
    int result = -1;
    for (int i = 0; i < relacoes.size(); i++) {
      Relacao rel = relacoes.get(i);
      if (dist(x, y, rel.posX, rel.posY) < Relacao.RAIO) {
        result = i;
        break;
      }
    }
    return result;
  }

  int pegaEstado(int x, int y) {
    int result = -1;
    for (int i = 0; i < estados.size(); i++) {
      Estado e = estados.get(i);
      if (dist(x, y, e.posX, e.posY) < Estado.RAIO) {
        result = i;
        break;
      }
    }
    return result;
  }

  void defineInicial(int x, int y) {
    int estado = pegaEstado(x, y);

    if (estado != -1) {
      Estado e = estados.get(estado);
      if (!e.ini) {
        for (Estado est : estados) {
          est.ini = false;
        }
        e.ini = true;
      } else {
        e.ini = false;
      }
    }
  }

  void defineFinal(int x, int y) {
    int estado = pegaEstado(x, y);
    if (estado != -1) {
      Estado e = estados.get(estado);
      if (!e.fin) {
        e.fin = true;
      } else {
        e.fin = false;
      }
    }
  }

  void desenha() {
    background(100);
    desenhaMenu();
    desenhaRelacoes();
    desenhaEstados();


    if (atividade == ATIV_ESTADOS) {
      if (aux == 1) {
        aux1.posX = mouseX;
        aux1.posY = mouseY;
        for (Relacao r : relacoes) {
          r.calculaPosicoes();
        }
      }
    }
  }

  void desenhaMenu() {
    textSize(30);
    fill(255);
    text("Autômato Finito Deterministico", width / 2, 30);

    textAlign(LEFT, CENTER);

    textSize(18);

    if (atividade == ATIV_ESTADOS) fill(255, 0, 0);
    text("1 - Manipular Estados", 20, 30);

    fill(255);
    if (atividade == ATIV_RELACOES) fill(255, 0, 0);
    text("2 - Manipular Relacoes", 20, 60);

    fill(255);
    if (atividade == ATIV_TESTE) fill(255, 0, 0);
    text("3 - Testar Cadeia", 20, 90);

    fill(255, 50);

    if (atividade == ATIV_ESTADOS) {
      text("Botão esquerdo para criar novo estado", 20, 150);
      text("Botão direito para deletar o estado alvo", 20, 180);
      text("Pressione I com o cursor em um estado para torná-lo inicial", 20, 210);
      text("Pressione F com o cursor em um estado para torná-lo final", 20, 240);
      text("Segure M enquando move o mouse para trocar a posição do estado alvo", 20, 270);
    } else if (atividade == ATIV_RELACOES) {
      if (aux == 0) {
        text("Clique na origem", 20, 150);
        text("Pressione D no circulo de uma relação para deletá-la", 20, 180);
      }
      if (aux == 1) text("Clique no destino", 20, 150);
      if (aux == 2) {
        text("Digite os caracteres para esta relação", 20, 150);
        text("Espaço para confirmar", 20, 180);
        text("Botão direito para cancelar", 20, 210);
        text("Backspace para apagar o último caractere", 20, 240);
      }
    } else if (atividade == ATIV_TESTE) {
      if (aux == 0) {
        textAlign(CENTER, CENTER);
        pushStyle();
        fill(255, 255, 0);
        text("Digite a cadeia a ser testada", width / 2, 120);
        popStyle();
        textAlign(LEFT, CENTER);
        text("Espaço para iniciar o teste", 20, 150);
      } else {
        text("Espaço para reiniciar o teste", 20, 150);
        if (aux == 1) text("Clique para executar o próximo passo", 20, 180);
      }


      textAlign(CENTER, CENTER);

      String teste = "", testada = "";
      for (char c : cadeiaTeste) {
        teste += c;
      }
      for (char c : cadeiaTestada) {
        testada += c;
      }

      fill(255);
      text("Cadeia a testar: " + teste, width / 2, 150);
      text("Cadeia testada: " + testada, width / 2, 180);

      if (aux == 2) {
        fill(255, 0, 0);
        text("CADEIA RECUSADA", width / 2, 210);
      } else if (aux == 3) {
        fill(0, 255, 0);
        text("CADEIA ACEITA", width / 2, 210);
      } else if (aux == 4) {
        fill(255, 255, 0);
        text("FALTANDO ESTADO INICIAL OU FINAL", width / 2, 210);
      }

      textAlign(LEFT, CENTER);
    }


    textAlign(CENTER, CENTER);
  }

  void desenhaRelacoes() {
    stroke(0, 100);
    strokeWeight(3);
    textSize(24);
    for (int i = 0; i < relacoes.size(); i++) {
      Relacao rel = relacoes.get(i);
      if (!rel.self) {
        line(rel.x1, rel.y1, rel.x2, rel.y2);
        fill(255, 0, 0);
        for (int j = 0; j < rel.caracteres.size(); j++) {
          text(rel.caracteres.get(j), rel.posX + rel.dir.x * 20 * (j + 2), rel.posY + rel.dir.y * 20 * (j + 2));
        }
      } else {
        noFill();
        ellipse(rel.posX, rel.posY + Estado.RAIO, Estado.RAIO, Estado.RAIO * 2);
        fill(255, 0, 0);
        for (int j = 0; j < rel.caracteres.size(); j++) {
          text(rel.caracteres.get(j), rel.posX, rel.posY - 4 - 20 * (j + 1));
        }
      }
      fill(0);
      ellipse(rel.posX, rel.posY, Relacao.RAIO * 2, Relacao.RAIO * 2);
    }
  }

  void desenhaEstados() {
    noStroke();
    for (int i = 0; i < estados.size(); i++) {
      Estado e = estados.get(i);

      if (e.sel) {
        fill(0, 255, 0);
        ellipse(e.posX, e.posY, Estado.RAIO * 2.5, Estado.RAIO * 2.5);
      }

      if (e.fin && e.ini) {
        fill(255, 0, 0);
        ellipse(e.posX, e.posY, Estado.RAIO * 2, Estado.RAIO * 2);
        fill(0, 0, 255);
        ellipse(e.posX, e.posY, Estado.RAIO * 1.7, Estado.RAIO * 1.7);
      } else if (e.ini) {
        fill(0, 0, 255);
        ellipse(e.posX, e.posY, Estado.RAIO * 2, Estado.RAIO * 2);
      } else if (e.fin) {
        fill(255, 0, 0);
        ellipse(e.posX, e.posY, Estado.RAIO * 2, Estado.RAIO * 2);
      } else {
        fill(255);
        ellipse(e.posX, e.posY, Estado.RAIO * 2, Estado.RAIO * 2);
      }

      textSize(32);
      fill(0);
      text("q" + i, e.posX, e.posY - 6);
    }
  }

  boolean checarCaractere(Estado e, char tecla) {
    boolean result = true;
    for (int i = 0; i < relacoes.size(); i++) {
      Relacao rel = relacoes.get(i);
      if (rel.origem == e) {
        for (int j = 0; j < rel.caracteres.size(); j++) {
          if (tecla == rel.caracteres.get(j)) {
            result = false;
            break;
          }
        }
        if (!result) break;
      }
    }

    return result;
  }

  void processaTeclaSolta(char tecla, int x, int y) {
    if (tecla == 'm' || tecla == 'M') {
      if (atividade == ATIV_ESTADOS) {
        if (aux == 1) reseta();
      }
    }
  }

  void processaClique(int botao, int x, int y) {
    switch(atividade) {
    case ATIV_ESTADOS:
      if (aux == 0) {
        if (botao == LEFT) {
          adicionaEstado(x, y);
        } else {
          removeEstado(x, y);
        }
      }
      break;
    case ATIV_RELACOES:
      if (botao == RIGHT) {
        reseta();
        return;
      }
      int estado = pegaEstado(x, y);
      if (estado == -1) return;
      if (aux == 0) {
        aux1 = estados.get(estado);
        aux1.sel = true;
        aux = 1;
      } else if (aux == 1) {
        aux2 = estados.get(estado);
        aux2.sel = true;
        aux = 2;
        relacoes.add(new Relacao(aux1, aux2));
      }
      break;
    case ATIV_TESTE:
      if (aux == 1) testaCadeia();
      break;
    default:
      break;
    }
  }

  void processaTecla(char tecla, int x, int y) {
    if (trocaAtividade(tecla)) return;
    switch(atividade) {
    case ATIV_ESTADOS:
      if (tecla == 'i' || tecla == 'I') {
        defineInicial(x, y);
      } else if (tecla == 'f' || tecla == 'F') {
        defineFinal(x, y);
      } else if (tecla == 'm' || tecla == 'M') {
        int estado = pegaEstado(x, y);
        if (estado != -1) {
          aux1 = estados.get(estado);
          aux1.sel = true;
          aux = 1;
        }
      }
      break;
    case ATIV_RELACOES:
      if (aux == 0) {
        if (tecla == 'd' || tecla == 'D') removeRelacao(x, y);
      } else if (aux == 2) {
        if (tecla == BACKSPACE) {
          relacoes.get(relacoes.size() - 1).removeCaractere();
        } else if (tecla == ' ') {
          if (relacoes.get(relacoes.size() - 1).caracteres.size() > 0) {
            aux1.sel = false;
            aux2.sel = false;
            aux = 0;
          }
        } else if (tecla >= 'A' && tecla <= 'z') {
          if (checarCaractere(aux1, tecla))relacoes.get(relacoes.size() - 1).adicionaCaractere(tecla);
        }
      }
      break;
    case ATIV_TESTE:
      if (aux == 0) {
        if (tecla == BACKSPACE) {
          if (cadeiaTeste.size() > 0) cadeiaTeste.remove(cadeiaTeste.size() - 1);
        } else if (tecla == ' ') {
          testaCadeia();
        } else if (tecla >= 'A' && tecla <= 'z') {
          cadeiaTeste.add(tecla);
        }
      } else {
        if (tecla == ' ') {
          reseta();
        }
      }
      break;
    default:
      break;
    }
  }
}

class Estado {
  static final int RAIO = 33;
  int posX, posY;
  boolean ini, fin, sel;

  Estado(int x, int y) {
    this.posX = x;
    this.posY = y;
  }
}

class Relacao {
  final static int RAIO = 8;
  Estado origem, destino;
  boolean self;
  ArrayList<Character> caracteres = new ArrayList();
  int x1, y1, x2, y2, posX, posY;
  PVector dir;

  Relacao(Estado origem, Estado destino) {
    this.origem = origem;
    this.destino = destino;
    calculaPosicoes();
  }

  void adicionaCaractere(char caractere) {
    caracteres.add(caractere);
  }

  void removeCaractere() {
    if (caracteres.size() > 0) caracteres.remove(caracteres.size() - 1);
  }

  void calculaPosicoes() {
    PVector v = new PVector(destino.posX - origem.posX, destino.posY - origem.posY);
    dir = v.copy().normalize();
    float x = (1 * dir.y);
    float y = (-dir.x);
    x1 = round(origem.posX + x * Estado.RAIO / 2);
    y1 = round(origem.posY + y * Estado.RAIO / 2);
    x2 = round(destino.posX + x * Estado.RAIO / 2);
    y2 = round(destino.posY + y * Estado.RAIO / 2);
    posX = round(x1 + dir.x * (Estado.RAIO + RAIO));
    posY = round(y1 + dir.y * (Estado.RAIO + RAIO));
    if (x1 == x2 && y1 == y2) {
      posY -= Estado.RAIO * 2;
      self = true;
    }
  }
}
