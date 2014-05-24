float escala = 30f;
float max = 10f;
float min = 10f;

Catador[] catadores;
int i;

Table table;

PVector posicion;

// Direcciones posibles a moverse en el grafo (positivo y negativo)
PVector tono_p, tono_n;
PVector aroma_p, aroma_n;
PVector sabor_p, sabor_n;
PVector persistencia_p, persistencia_n; 

void setup() {
  size(800, 800);

  loadData();

  direcciones();

  i = 0;
  noSmooth();
  strokeWeight(1);
  translate(width / 2, height / 2);
  scale(1, -1);
  ejes();
  leyenda();
}

void draw() {
  //frameRate(1);
  noSmooth();
  strokeWeight(1);
  translate(width / 2, height / 2);
  scale(1, -1);
  

  posicion = new PVector(0, 0);

  // Puntos para el primer vino
  //for(Catador catador : catadores) {
  if (i < catadores.length) {
    Catador catador = catadores[i];
    // Reiniciamos la posición
    posicion.x = 0;
    posicion.y = 0;

    // Reiniciamos el color
    int opacidad = 0; 

    Vino vino = catador.vinos[0];

    // Color
    float t = vino.tono - vino.global;
    if (t > 0) {
      pintarPunto(tono_p, t, opacidad);
    } else if (t < 0) {
      pintarPunto(tono_n, -t, opacidad);
    }
    opacidad += 64;

    // Aroma
    float a = vino.aroma - vino.global;
    if (a > 0) {
      pintarPunto(aroma_p, a, opacidad);
    } else if (a < 0) {
      pintarPunto(aroma_n, -a, opacidad);
    }
    opacidad += 64;

    // Sabor
    float s = vino.sabor - vino.global;
    if (s > 0) {
      pintarPunto(sabor_p, s, opacidad);
    } else if (s < 0) {
      pintarPunto(sabor_n, -s, opacidad);
    }
    opacidad += 64;

    // Persistencia
    float p = vino.persistencia - vino.global;
    if (p > 0) {
      pintarPunto(persistencia_p, p, opacidad);
    } else if (p < 0) {
      pintarPunto(persistencia_n, -p, opacidad);
    }
    opacidad += 64;
  }

  i++; 

  //  File file = new File("test.png");
  //  if (!file.exists())
  //  {
  //    save("test.png");
  //  }
}

void pintarPunto(PVector direccion, float valor, int opacidad) {
  pushStyle();
  smooth(8);
  strokeWeight(5);
  posicion.x = posicion.x + valor * escala * direccion.x;
  posicion.y = posicion.y + valor * escala * direccion.y;
  stroke(opacidad);
  point(posicion.x, posicion.y);
  println("Punto" + posicion.x + " " + posicion.y);
  popStyle();
}

void direcciones() {
  // Vectores unitarios para todas las direcciones
  tono_p = new PVector(1, 0);
  tono_n = new PVector(1, 0);
  aroma_p = new PVector(1, 0);
  aroma_n = new PVector(1, 0);
  sabor_p = new PVector(1, 0);
  sabor_n = new PVector(1, 0);
  persistencia_p = new PVector(1, 0);
  persistencia_n = new PVector(1, 0);

  // Rotaciones para cada eje
  float tono_r = 150;
  float aroma_r = 120;
  float sabor_r = 60;
  float persistencia_r = 30;

  // Rotamos los vectores unitarios para que tomen la dirección del eje correspondiente
  tono_p.rotate(radians(tono_r));
  tono_n.rotate(radians(-tono_r));
  aroma_p.rotate(radians(aroma_r));
  aroma_n.rotate(radians(-aroma_r));
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

  stroke(255, 0, 0);
  line(0, 0, tono_p.x * escala * max, tono_p.y * escala * max);
  line(0, 0, tono_n.x * escala * min, tono_n.y * escala * min);

  stroke(color(255, 255, 0));
  line(0, 0, aroma_p.x * escala * max, aroma_p.y * escala * max);
  line(0, 0, aroma_n.x * escala * min, aroma_n.y * escala * min);

  stroke(color(0, 255, 0));
  line(0, 0, sabor_p.x * escala * max, sabor_p.y * escala * max);
  line(0, 0, sabor_n.x * escala * min, sabor_n.y * escala * min);

  stroke(color(0, 0, 255));
  line(0, 0, persistencia_p.x * escala * max, persistencia_p.y * escala * max);
  line(0, 0, persistencia_n.x * escala * min, persistencia_n.y * escala * min);

  stroke(0);
}

void leyenda() {
  pushMatrix();
  scale(1, -1);
  translate(- width / 2 + 20, - height / 2 + 20);

  fill(255, 0, 0);
  text("color", 20, 20);

  fill(color(255, 255, 0));
  text("aroma", 20, 40);

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
  int cons_n = 0; // Numero de consumidor
  int tono_p, aroma, sabor, persistencia, global;
  Vino[] vinos;

  for (TableRow row : table.rows ()) {
    vinos = new Vino[8];  
    tono_p = aroma = sabor = persistencia = global = 0;
    for (int i = 0; i < 8; i++) {
      tono_p = row.getInt("color" + str(i));
      aroma = row.getInt("olor" + str(i));
      sabor = row.getInt("sabor" + str(i));
      persistencia = row.getInt("persistencia" + str(i));
      global = row.getInt("global" + str(i));
      vinos[i] = new Vino(tono_p, aroma, sabor, persistencia, global);
    }

    catadores[cons_n] = new Catador(vinos);
    cons_n++;
  }
}

