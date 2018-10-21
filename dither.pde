PImage img;
float oldR, oldG, oldB, newR, newG, newB, R, G, B, errR, errG, errB;
int i, range = 3;
boolean edgeX, edgeY;
ArrayList<Particle> bubbles;
Particle[] bubblesArray;

int index(int x, int y) {
  return x + y * img.width;
}




void setup() {
  background(0);
  img = loadImage("tower2.png");
  size(1024, 684);
  //image(img, 0, 0);
  //img.filter(GRAY);
  img.loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      color pix = img.pixels[index(x, y)]; // wczytaj kolor aktualnego piksela
      oldR = red(pix);   // podziel kolor na R,
      oldG = green(pix); // G,
      oldB = blue(pix);  // B
      newR = round(range * oldR / 255) * (255/range); // kwantyzuj
      newG = round(range * oldG / 255) * (255/range);
      newB = round(range * oldB / 255) * (255/range);
      errR = oldR - newR;  // policz błąd
      errG = oldG - newG;
      errB = oldB - newB;
      img.pixels[index(x, y)] = color(newR, newG, newB); // nadaj kolor natywnemu pikselowi
      // nadaj kolor sąsiadom:
      img.pixels[index(x+1, y    )] = img.pixels[index(x+1, y  )] + color(errR * 7/16, errG * 7/16, errB * 7/16);
      img.pixels[index(x-1, y + 1)] = img.pixels[index(x-1, y+1)] + color(errR * 3/16, errG * 3/16, errB * 3/16);
      img.pixels[index(x, y + 1)] = img.pixels[index(x, y+1)] + color(errR * 5/16, errG * 5/16, errB * 5/16);
      img.pixels[index(x+1, y + 1)] = img.pixels[index(x+1, y+1)] + color(errR * 1/16, errG * 1/16, errB * 1/16);
    }
  }
  img.updatePixels(); // zaktualizuj macierz pikseli
  //img.resize(img.width*2, img.height*2); // powiększ zdjęcie
  //image(img, 512/2, 342/2); // wyświetl zdjęcie


  bubbles = new ArrayList<Particle>();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      float by = map(y, 0, img.height-1, 0, height-1);
      float bx = map(x, 0, img.width-1, 0, width-1);
      Particle b = new Particle(bx, by, 8, img.pixels[index(x, y)]);
      bubbles.add(b);
    }
  }
  bubblesArray = new Particle[ bubbles.size() ];
  bubbles.toArray( bubblesArray );
}

int t = 0;

void draw() {
  background(0);
  for (int i = 0; i < bubblesArray.length; i++) {
    Particle c = bubblesArray[i];
    c.show(true);
    c.physics();
  }
  t++;
}


//EVENTS

PVector mousePos, mouseForce;
void mousePressed() {
  mouseForce = new PVector(mouseX, mouseY);
}

void mouseReleased() {
  mousePos = new PVector(mouseX, mouseY);
  mousePos.sub(mouseForce);
  print(mouseForce);
  for (int i = 0; i < bubblesArray.length; i++) {
    Particle c = bubblesArray[i];
    c.apply(mousePos);
  }
}