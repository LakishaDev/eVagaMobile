import 'package:evaga/models/tip_uredjaja.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PostavkeUredjaja extends ChangeNotifier {
  String ip = '';
  int port = 8080;
  TipUredjaja tip = TipUredjaja.a12;

  final String boxName = 'postavkeUredjaja';

  PostavkeUredjaja() {
    load();
  }

  Future<void> load() async {
    var box = await Hive.openBox(boxName);
    ip = box.get('ip', defaultValue: '');
    port = box.get('port', defaultValue: 8080);
    int tipIndex = box.get('tip', defaultValue: 0);
    tip = TipUredjaja.values[tipIndex];
    notifyListeners();
  }

  Future<void> save() async {
    var box = await Hive.openBox(boxName);
    await box.put('ip', ip);
    await box.put('port', port);
    await box.put('tip', tip.index);
  }

  Future<void> reset() async {
    ip = '';
    port = 8080;
    tip = TipUredjaja.a12;
    var box = await Hive.openBox(boxName);
    await box.deleteAll([
      'ip',
      'port',
      'tip',
    ]); // obriši stare vrednosti
    notifyListeners();
  }

  void setIp(String value) {
    ip = value;
    notifyListeners();
  }

  void setPort(int value) {
    port = value;
    notifyListeners();
  }

  void setTip(TipUredjaja value) {
    tip = value;
    notifyListeners();
  }
}
