ArrayList<PVector> destino;
ArrayList<PVector> dibujante;
ArrayList<PVector> movimiento;
PVector origen;
float radio;
int lados;

void setup() {
  size(500, 500, P2D);
  strokeWeight(1.5);
  colorMode(HSB, 360, 100, 100, 100);
  // "Hue, Saturation, Brightness" colour mode (instead of RBG)
  background(0, 0, 90);
  frameRate(30);
  radio = width/3;
  lados = 3;
  destino = new ArrayList<PVector>();
  dibujante = new ArrayList<PVector>();
  movimiento = new ArrayList<PVector>();
  origen = new PVector(0, 0);
  float angulo = 0;
  for (int i = 0; i < lados; i++) {
    destino.add(new PVector(radio*cos(angulo), radio*sin(angulo)));
    angulo += TWO_PI/lados;
    dibujante.add(new PVector(0, 0));
    movimiento.add(destino.get(i).get());
    movimiento.get(i).normalize();
  }
}

color from = color(0, 0, 100);
color to = color(0, 100, 100);
float paso = 0;
float radio_inicio = 0;


void draw() {
  background(0, 0, 90);
  stroke(128);
  translate(height/2, width/2);
/*
  if (PVector.dist(origen, dibujante.get(0)) > radio_inicio) {
    paso = map(
          PVector.dist(origen, dibujante.get(0)), 
          PVector.dist(origen, origen), 
          PVector.dist(origen, destino.get(0)), 
          0.0, 
          1.0);
    println(paso);
    stroke(lerpColor(from, to, paso));
  }
  else {
    stroke(0, 0, 100);
  }
*/
  if (PVector.dist(destino.get(0), dibujante.get(0)) > 1) {
    for (int i = 0; i < destino.size(); i++) {
      println("Lados " + i%lados + "; lados+1 " + (i+1)%lados);
      line(
        dibujante.get(i%lados).x,
        dibujante.get(i%lados).y,
        dibujante.get((i+1)%lados).x,
        dibujante.get((i+1)%lados).y);
    }
    for (int i = 0; i < destino.size(); i++) 
      dibujante.get(i).add(movimiento.get(i));
  }
  else {
    for (int i = 0; i < destino.size(); i++) {
      dibujante.get(i).set(0, 0, 0);
    }
  }
}

