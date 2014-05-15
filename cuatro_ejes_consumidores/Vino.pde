

class Vino {
  int tono, olor, sabor, persistencia;
  int global;
 
  Vino (int tono_, int olor_, int sabor_, int pers_, int global_) {
    tono = tono_;
    olor = olor_;
    sabor = sabor_;
    persistencia = pers_;
    global = global_;
  }
  
  String to_s() {
    String cad = "";
    cad += "\t\tTono: " + str(tono) + "\n";
    cad += "\t\tOlor: " + str(olor) + "\n";
    cad += "\t\tSabor: " + str(sabor) + "\n";
    cad += "\t\tPers.: " + str(persistencia) + "\n";
    cad += "\t\tGlobal: " + str(global) + "\n";
    return cad;
  }
}
