ArrayList<Integer> pilha = new ArrayList();

int[] cadeia;

String[] simbolos = {"E", "E'", "T", "T'", "F", "id", "v", "&", "¬", "$"};

int QNT = 5, indice = 0;
int[][][] tabela = {
  {  {i("T"), i("E'")}, {-1}, {-1}, {i("T"), i("E'")}, {-1}  }, 
  {  {-1}, {i("v"), i("T"), i("E'")}, {-1}, {-1}, {-2}  }, 
  {  {i("F"), i("T'")}, {-1}, {-1}, {i("F"), i("T'")}, {-1}  }, 
  {  {-1}, {-2}, {i("&"), i("F"), i("T'")}, {-1}, {-2}  }, 
  {  {i("id")}, {-1}, {-1}, {i("¬"), i("F")}, {-1}  }
};

void setup() {
  pilha.add(i("$"));
  pilha.add(i("E"));

  cadeia = new int[] { i("id"), i("v"), i("id"), i("&"), i("id"), i("$") };

  boolean sucesso = false;

  while (true) {
    
    
    int simP = pilha.remove(pilha.size() - 1);
    if (simP == i("$")) {
      sucesso = true;
      break;
    }

    if(cadeia[indice] == -1) break;

    if (simP >= QNT) {
      if (simP != cadeia[indice]) break;
      indice++;
    } else {
      
      int[] regra = tabela[simP][cadeia[indice] - QNT];
      if(regra[0] == -1) break;
      if(regra[0] == -2) continue;
      for (int i = regra.length - 1; i >= 0; i--) {
        pilha.add(regra[i]);
      }
    }
  }
  
  print(sucesso);
}

int i(String s) {
  int result = -1;
  for (int i = 0; i < simbolos.length; i++) {
    if (s.equals(simbolos[i])) {
      result = i;
      break;
    }
  }
  return result;
}
