

class Catador {
  Vino[] vinos;

  Catador(Vino[] vinos_) {
    vinos = vinos_;
  }

  public String to_s() {
    String cad = "";
    int i = 0;
    for (Vino vino : vinos) {
      cad += "\tVino " + str(i) + "\n";
      cad += vino.to_s();
      if (++i >= 8) i = 0;
    }
    return cad;
  }
}

