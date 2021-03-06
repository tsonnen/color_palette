import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/color_palette.dart';
import '../models/swatch_model.dart';

class ColorPaletteBox extends ChangeNotifier {
  final key = 'color_palettes';
  List<ColorPalette> colorPalettes;

  ColorPaletteBox() : colorPalettes = List<ColorPalette>.empty(growable: true);

  Future<void> init() async {
    Hive.registerAdapter(ColorPaletteAdapter());
    Hive.registerAdapter(SwatchModelAdapter());
    await Hive.openBox<ColorPalette>(key);

    getColorPalettes();
  }

  void getColorPalettes() {
    var box = Hive.box<ColorPalette>(key);
    colorPalettes = box.values.toList();

    notifyListeners();
  }

  Future<void> deleteColorPalette(ColorPalette colorPalette) async {
    var box = Hive.box<ColorPalette>(key);
    await box.delete(colorPalette);

    getColorPalettes();
  }

  Future<void> addColorPalette(ColorPalette colorPalette) async {
    var box = Hive.box<ColorPalette>(key);
    await box.add(colorPalette);

    getColorPalettes();
  }
}
