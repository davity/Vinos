float escala = 30f;
float max = 10f;
float min = 10f;

Catador[] catadores;

// Rotaciones para cada eje
float tono_r = 150;
float olor_r = 120;
float sabor_r = 60;
float persistencia_r = 30;

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
    
  // Vectores unitarios para todas las direcciones
  tono_p = new PVector(1,0);
  tono_n = new PVector(1,0);
  olor_p = new PVector(1,0);
  olor_n = new PVector(1,0);
  sabor_p = new PVector(1,0);
  sabor_n = new PVector(1,0);
  persistencia_p = new PVector(1,0);
  persistencia_n = new PVector(1,0);
  
  direcciones();
}

void draw() {
  noSmooth();
  strokeWeight(1);
  translate(width / 2, height / 2);
  scale(1,-1);
  ejes();
  leyenda();
  
  smooth(8);
  strokeWeight(5);
  posicion = new PVector(0,0);
  
  posicion = new PVector(posicion.x + 4 * escala * tono_p.x, posicion.y + 4 * escala * tono_p.y);
  stroke(0);
  point(posicion.x, posicion.y);
  
  posicion = new PVector(posicion.x + 4 * escala * olor_p.x, posicion.y + 4 * escala * olor_p.y);
  stroke(32);
  point(posicion.x, posicion.y);
  
  posicion = new PVector(posicion.x + 3 * escala * sabor_p.x, posicion.y + 3 * escala * sabor_p.y);
  stroke(64);
  point(posicion.x, posicion.y);
  
  posicion = new PVector(posicion.x + 1 * escala * persistencia_p.x, posicion.y + 1 * escala * persistencia_p.y);
  stroke(96);
  point(posicion.x, posicion.y);
  
  File file = new File("test.png");
  if (!file.exists())
  {
    save("test.png");
  } 
  
}

void direcciones() {
  // Rotamos los vectores unitarios para que tomen la dirección del eje correspondiente
  tono_p.rotate(radians(tono_r));
  tono_n.rotate(radians(-tono_r));
  olor_p.rotate(radians(olor_r));
  olor_n.rotate(radians(-olor_r));
  sabor_p.rotate(radians(sabor_r));
  sabor_n.rotate(radians(-sabor_r));
  persistencia_p.rotate(radians(persistencia_r));
  persistencia_n.rotate(radians(-persistencia_r));
}

void ejes() {
  noSmooth();
  stroke(0);
  line(- escala * max, 0, escala * max, 0);
  line(0, - escala * min, 0, escala * min);
  
  stroke(255,0,0);
  line(0,0, tono_p.x * escala * max, tono_p.y * escala * max);
  line(0,0, tono_n.x * escala * min, tono_n.y * escala * min);
  
  stroke(color(255, 255, 0));
  line(0,0, olor_p.x * escala * max, olor_p.y * escala * max);
  line(0,0, olor_n.x * escala * min, olor_n.y * escala * min);
  
  stroke(color(0, 255, 0));
  line(0,0, sabor_p.x * escala * max, sabor_p.y * escala * max);
  line(0,0, sabor_n.x * escala * min, sabor_n.y * escala * min);
  
  stroke(color(0, 0, 255));
  line(0,0, persistencia_p.x * escala * max, persistencia_p.y * escala * max);
  line(0,0, persistencia_n.x * escala * min, persistencia_n.y * escala * min);
  
  stroke(0);
}

void leyenda() {
  pushMatrix();
  scale(1,-1);
  translate(- width / 2 + 20, - height / 2 + 20);
  
  fill(255,0,0);
  text("color", 20, 20);
  
  fill(color(255, 255, 0));
  text("olor", 20, 40);
  
  fill(color(0, 255, 0));
  text("sabor", 20, 60);
  
  fill(color(0, 0, 255));
  text("persistencia", 20, 80);
  popMatrix();
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

