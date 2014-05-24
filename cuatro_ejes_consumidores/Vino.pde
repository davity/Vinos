

class Vino {
  int tono, aroma, sabor, persistencia;
  int global;
 
  Vino (int tono_, int aroma_, int sabor_, int pers_, int global_) {
    tono = tono_;
    aroma = aroma_;
    sabor = sabor_;
    persistencia = pers_;
    global = global_;
  }
  
  String to_s() {
    String cad = "";
    cad += "\t\tTono: " + str(tono) + "\n";
    cad += "\t\tAroma: " + str(aroma) + "\n";
    cad += "\t\tSabor: " + str(sabor) + "\n";
    cad += "\t\tPers.: " + str(persistencia) + "\n";
    cad += "\t\tGlobal: " + str(global) + "\n";
    return cad;
  }
}
