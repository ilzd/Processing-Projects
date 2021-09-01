PGraphics cracha;
PImage background, qrcode;
String name;

int bgWidth, bgHeight;
int qrSize, qrX, qrY ;
int nameWidth, nameHeight, nameX, nameY; 

void setup() {
  size(500, 500);
  background(0);


  File qrcodesDir = new File(dataPath("qrcodes/"));
  File[] files = qrcodesDir.listFiles();

  String[] info = loadStrings("info.txt");
  String[] data;
  for (int i = 0; i < info.length; i++) {
    data = info[i].split("=");
    switch(data[0]) {
    case "nameWidth":
      nameWidth = Integer.valueOf(data[1]);
      break;
    case "nameHeight":
      nameHeight = Integer.valueOf(data[1]);
      break;
    case "nameX":
      nameX = Integer.valueOf(data[1]);
      break;
    case "nameY":
      nameY = Integer.valueOf(data[1]);
      break;
    case "qrcodeSize":
      qrSize = Integer.valueOf(data[1]);
      break;
    case "qrcodeX":
      qrX = Integer.valueOf(data[1]);
      break;
    case "qrcodeY":
      qrY = Integer.valueOf(data[1]);
      break;
    case "bgWidth":
      bgWidth = Integer.valueOf(data[1]);
      break;
    case "bgHeight":
      bgHeight = Integer.valueOf(data[1]);
      break;
    default:
      break;
    }
  }

  nameX = nameX + nameWidth / 2;
  nameY = nameY + nameHeight / 2;

  background = loadImage("background.png");
  background.resize(bgWidth, bgHeight);

  File fontFile = new File(dataPath("font.ttf"));


  for (File f : files) {
    qrcode = loadImage(f.getPath());
    qrcode.resize(qrSize, qrSize);
    name = capitalize(getFileShortName(f));

    cracha = createGraphics(bgWidth, bgHeight);
    cracha.smooth(8);
    cracha.beginDraw();

    if (fontFile.exists()) {
      PFont font = createFont(fontFile.getPath(), 32);
      cracha.textFont(font);
    }

    cracha.fill(0);
    cracha.textAlign(CENTER, CENTER);

    cracha.image(background, 0, 0);
    cracha.image(qrcode, qrX, qrY);

    int nameSize = 1;
    while (true) {
      cracha.textSize(nameSize);
      if (cracha.textWidth(name) >= nameWidth) {
        cracha.textSize(nameSize - 1);
        break;
      }
      nameSize++;
    }

    if(!isCoringa(name))cracha.text(name, nameX, nameY);

    cracha.endDraw();
    cracha.save("data/crachas/" + f.getName());
  }

  textSize(100);
  text("DONE", 100, 100);
}

String getFileShortName(File file) {
  String shortName = file.getName();
  return shortName.substring(0, shortName.length()   - 4);
}

String capitalize(String text) {
  text = text.toLowerCase();
  String[] words = text.split(" ");
  String result = "";

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (!word.equals("da") && !word.equals("de") && !word.equals("do") && !word.equals("e") && !word.equals("a")) {
      words[i] = word.substring(0, 1).toUpperCase() + word.substring(1);
    }
  }

  for (int i = 0; i < words.length; i++) {
    result += words[i];
    if (i != words.length - 1) result += " ";
  }

  return result;
}

boolean isCoringa(String name){
  name = name.toLowerCase();
  return name.indexOf("participante") != -1;
}
