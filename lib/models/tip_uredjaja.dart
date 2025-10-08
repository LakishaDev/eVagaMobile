enum TipUredjaja { a12, dini, nid }

extension TipUredjajaExt on TipUredjaja {
  String get label {
    switch (this) {
      case TipUredjaja.a12:
        return "A12";
      case TipUredjaja.dini:
        return "Dini argeo";
      case TipUredjaja.nid:
        return "NID";
    }
  }
}
