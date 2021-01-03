import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:color_palette/models/color_palette_model.dart';
import 'package:flutter/cupertino.dart';

class ListenableMap extends MapMixin<String, ColorPaletteModel>
    with ChangeNotifier {
  final Map<String, ColorPaletteModel> m = {};
  String fileName;

  ListenableMap();
  ListenableMap.fromFile(this.fileName) {
    if (File(fileName).existsSync()) {
      // File(fileName).deleteSync();
      String data = File(fileName).readAsStringSync();
      Map tmp = jsonDecode(data);

      tmp.forEach((key, value) {
        m[key] = ColorPaletteModel.fromJson(value);
      });

      notifyListeners();
    }
  }

  @override
  ColorPaletteModel operator [](Object key) {
    return m[key];
  }

  @override
  void operator []=(String key, ColorPaletteModel value) {
    m[key] = value;
    notifyListeners();

    writeData();
  }

  @override
  void clear() {
    m.clear();
    notifyListeners();
  }

  @override
  Iterable<String> get keys => m.keys;

  @override
  ColorPaletteModel remove(Object key) {
    var val = m.remove(key);
    notifyListeners();
    return val;
  }

  void writeData() {
    var tmpJson = json.encode(m);
    File(fileName).writeAsStringSync(json.encode(m));
  }
}
