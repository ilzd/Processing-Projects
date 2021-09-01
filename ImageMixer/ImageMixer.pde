PImage img1, img2;

void setup() {
  fullScreen();
  img1 = loadImage("img1.jpg"); //carrega a primeira imagem na memoria
  img2 = loadImage("img2.png"); //carrega a segunda imagem na memoria

  img1.resize(500, 500); //redimensiona(só por conveniencia) a primeira imagem
  img2.resize(500, 500);//redimensiona(só por conveniencia) a segunda imagem

  image(mesclarImagens(img1, img2, 100, 50), 0, 0); //Mescla a segunda imagem na primeira
}

void draw() {
}


//px e py são as coordenadas onde a img2 será mesclada na img1
PImage mesclarImagens(PImage img1, PImage img2, int px, int py) {
  PImage resultado = img1.copy(); //faz uma copia da img1

  int index1, index2;
  resultado.loadPixels();
  for (int i = 0; i < img2.width; i++) { //loop pelos pixels horizontais da img2
    for (int j = 0; j < img2.height; j++) { //loop pelos pixels verticais da img2
      if (px + i < img1.width && py + j < img1.height) { //verifica se a coordenada desse pixel da img2 será visível na img1

        index1 = (py + j) * img1.width + i + px; //calcula o indice do pixel correspondente na img1 (pixels são guardados em um vetor de 1 dimensão no processing)
        index2 = j * img2.width + i; ////calcula o indice do pixel correspondente na img2 (pixels são guardados em um vetor de 1 dimensão no processing)
        resultado.pixels[index1] = calculaMedia(img1.pixels[index1], img2.pixels[index2], 10, 0); //Atualiza o pixel do resultado como resultado da média das cores
      }
    }
  }
  resultado.updatePixels();
  return resultado;
}

color calculaMedia(color c1, color c2, float p1, float p2) {
  if(p1 <= 0) p1 = 0.000001; //só pra não ter divisão por 0 (gambiarra temporária)
  if(p2 <= 0) p1 = 0.000001; //só pra não ter divisão por 0 (gambiarra temporária)
  
  float t1 = map(alpha(c1), 0, 255, 0, 1) * p1; //extrai a tranparencia da imagem, 0 pra totalmente transparente, 1 pra totalmente opaca
  float t2 = map(alpha(c2), 0, 255, 0, 1) * p2; //extrai a tranparencia da imagem, 0 pra totalmente transparente, 1 pra totalmente opaca

  //Calcula a média ponterada entre as cores, usando a transparencia de cada uma como peso
  float medidaVermelho = (red(c1) * t1 + red(c2) * t2) / (t1 + t2);
  float medidaVerde = (green(c1) * t1 + green(c2) * t2) / (t1 + t2);
  float medidaAzul = (blue(c1) * t1 + blue(c2) * t2) / (t1 + t2);
  return color(medidaVermelho, medidaVerde, medidaAzul);
}
