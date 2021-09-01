#include <stdio.h>

void main(){
  int x;
  int y;
  scanf("%d", &x);
  y=0;
  for(int INDICE_RESERVADO = 0; INDICE_RESERVADO < x; INDICE_RESERVADO++){
    y=y+1;
  }
  printf("%d", y);
}
