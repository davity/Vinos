import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.Axis2D;
import org.gwoptics.graphics.graph2D.LabelPos;
import org.gwoptics.graphics.GWColour;
import org.gwoptics.graphics.graph2D.backgrounds.GridBackground;


Catador[] catadores;
Graph2D axis;
Axis2D tono, aroma, sabor, persistencia;
float tono_r = 22.5;
float aroma_r = 67.5;
float persistencia_r = 112.5;
float sabor_r = 157.5;

Table table;

void setup() {
  size(800, 800);

  //loadData();
  //  for (int i = 0; i < catadores.length; i++) {
  //    print("Catador " + str(i) + "\n");
  //    print(catadores[i].to_s());
  //  }
  setupAxis();
  Math.signum(-14);
}

void draw() {
  ejes();

  translate(width / 2, height / 2);
  rotate(radians(-90));
}

void ejes() {
  pushMatrix();
  translate( width / 2 - axis.getXAxis().getLength() / 2, height / 2 - axis.getYAxis().getLength() / 2);
  noSmooth();
  axis.draw();
  popMatrix();


  pushMatrix();
  translate( width / 2, height / 2);
  rotate(radians(-180));
  
  pushMatrix();
  pushStyle();
  stroke(color(255,0,0));  
  rotate(radians(tono_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * tono_r));
  line(0, 0, 300, 0);
  popStyle();
  popMatrix();
  
  pushMatrix();
  pushStyle();
  stroke(color(255,255,0));
  rotate(radians(aroma_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * aroma_r));
  line(0, 0, 300, 0);
  popStyle();
  popMatrix();
  
  pushMatrix();
  pushStyle();
  stroke(color(0,255,0));
  rotate(radians(sabor_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * sabor_r));
  line(0, 0, 300, 0);
  popStyle();
  popMatrix();
  
  pushMatrix();
  pushStyle();
  stroke(color(0,255,255));
  rotate(radians(persistencia_r));
  line(0, 0, 300, 0);
  rotate(radians(-2 * persistencia_r));
  line(0, 0, 300, 0);
  popStyle();
  popMatrix();
  
  popMatrix();
}

void loadData() {
  table = loadTable("datos-consumidores-2007-estudio-1.csv", "header");
  catadores = new Catadores[table.getRowCount()];

  int rowCount = 0;
  int cons_n = 0;
  int tono_p, olor, sabor, persistencia, global;
  Vino[] vinos;

  for (TableRow row : table.rows()) {
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

void setupAxis() {
  // Base Axis
  axis = new Graph2D(this, 600, 600, true);
  axis.setNoBorder();
  axis.setXAxisMax(10);
  axis.setXAxisMin(-10);

  axis.setYAxisMax(10);
  axis.setYAxisMin(-10);

  axis.setXAxisTickSpacing(5);
  axis.setYAxisTickSpacing(5);

  axis.setXAxisLabel("");
  axis.setYAxisLabel("");

  axis.setXAxisMinorTicks(0);
  axis.setYAxisMinorTicks(0);

  axis.setXAxisLabelAccuracy(0);
  axis.setYAxisLabelAccuracy(0);

  axis.setGraphWidth(1);

//  // Eje tono_p
//  tono_p = new Axis2D(this, 600);
//  tono_p.setMaxValue(10);
//  tono_p.setMinValue(-10);
//  tono_p.setAxesDirection(new PVector(1,1));
//  tono_p.setAxisLabel("Color");
//  tono_p.setLabelOffset(-20);
//  tono_p.setLabelRotation(radians(180));
//  tono_p.setAxisLabelPos(LabelPos.OUTSIDE);
//  tono_p.setTickLabelAccuracy(0);
//  tono_p.setTickSpacing(5);
//  tono_p.setDrawTickLabels(false);
//  tono_p.setWidth(0);
}

