Consumidor[] consumidores;

Table table;

void setup() {
  size(800,800);
  loadData();
  for(int i = 0; i < consumidores.length; i++) {
    print("Consumidor " + str(i) + "\n");
    print(consumidores[i].to_s());
  }
}

void loadData() {
  table = loadTable("datos-consumidores-2007-estudio-1.csv", "header");
  consumidores = new Consumidor[table.getRowCount()];
  
  int rowCount = 0;
  int cons_n = 0;
  int tono, olor, sabor, persistencia, global;
  Vino[] vinos;
  
  for (TableRow row : table.rows()) {
    vinos = new Vino[8];  
    tono = olor = sabor = persistencia = global = 0;
    for (int i = 0; i < 8; i++) {
      tono = row.getInt("color" + str(i));
      olor = row.getInt("olor" + str(i));
      sabor = row.getInt("sabor" + str(i));
      persistencia = row.getInt("persistencia" + str(i));
      global = row.getInt("global" + str(i));
      vinos[i] = new Vino(tono, olor, sabor, persistencia, global);
    }
      
    consumidores[cons_n] = new Consumidor(vinos);
    cons_n++;
  }
}
