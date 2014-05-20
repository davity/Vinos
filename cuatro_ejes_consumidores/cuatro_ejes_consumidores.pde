float escala = 30f;

Catador[] catadores;

// Rotaciones para cada eje
float tono_r = 22.5;
float olor_r = 67.5;
float persistencia_r = 112.5;
float sabor_r = 157.5;

Table table;

PVector posicion;

// Direcciones posibles a moverse en el grafo (positivo y negativo)
PVector tono_p, tono_n;
PVector olor_p, olor_n;
PVector sabor_p, sabor_n;
PVector persistencia_p, persistencia_n; 

void setup() {
  size(800, 800);

  //loadData();
  //  for (int i = 0; i < catadores.length; i++) {
  //    print("Catador " + str(i) + "\n");
  //    print(catadores[i].to_s());
  //  }
  
  tono_p = new PVector(1,0);
  tono_n = new PVector(1,0);
  olor_p = new PVector(1,0);
  olor_n = new PVector(1,0);
  sabor_p = new PVector(1,0);
  sabor_n = new PVector(1,0);
  persistencia_p = new PVector(1,0);
  persistencia_n = new PVector(1,0);
}

void draw() {
  //smooth();
  ejes();

  translate(width / 2, height / 2);
  rotate(radians(-90));

  pushStyle();
  stroke(0, 0, 0);
  strokeWeight(5);
  posicion = new PVector(12, 14);
  posicion.normalize();
  point(posicion.x * 5 * escala, posicion.y*3*escala);
  popStyle();
}

void ejes() {
  pushStyle();
  strokeWeight(1);
  noSmooth();
  
  // Ejes X-Y
  pushMatrix();
  translate( width / 2, height / 2);
  stroke(0);
  line(-300, 0, 300, 0);
  line(0, -300, 0, 300);
  rotate(radians(-180));

  // Ejes tono
  pushMatrix();
  stroke(color(255, 0, 0));  
  rotate(radians(tono_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * tono_r));
  line(0, 0, 300, 0);
  popMatrix();

  // Ejes olor
  pushMatrix();
  stroke(color(255, 255, 0));
  rotate(radians(olor_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * olor_r));
  line(0, 0, 300, 0);
  popMatrix();

  // Ejes sabor
  pushMatrix();
  stroke(color(0, 255, 0));
  rotate(radians(sabor_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * sabor_r));
  line(0, 0, 300, 0);
  popMatrix();

  // Ejes persistencia
  pushMatrix();
  stroke(color(0, 255, 255));
  rotate(radians(persistencia_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * persistencia_r));
  line(0, 0, 300, 0);
  popMatrix();

  popMatrix();
  smooth(8);
  popStyle();
}

void loadData() {
  table = loadTable("datos-consumidores-2007-estudio-1.csv", "header");
  catadores = new Catador[table.getRowCount()];

  int rowCount = 0;
  int cons_n = 0;
  int tono_p, olor, sabor, persistencia, global;
  Vino[] vinos;

  for (TableRow row : table.rows ()) {
    vinos = new Vino[8];  
    tono_p = olor = sabor = persistencia = global = 0;
    for (int i = 0; i < 8; i++) {
      tono_p = row.getInt("color" + str(i));
      olor = row.getInt("olor" + str(i));
      sabor = row.getInt("sabor" + str(i));
      persistencia = row.getInt("persistencia" + str(i));
      global = row.getInt("global" + str(i));
      vinos[i] = new Vino(tono_p, olor, sabor, persistencia, global);
    }

    catadores[cons_n] = new Catador(vinos);
    cons_n++;
  }
}

