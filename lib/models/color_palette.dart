import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'swatch_model.dart';

part 'color_palette.g.dart';

enum GenMethod { rand, pastel, median }

@HiveType(typeId: 0)
class ColorPalette extends ChangeNotifier {
  @HiveField(0)
  late List<SwatchModel> colors;

  int get length => colors.length;

  ColorPalette.generated({required int length, required GenMethod genMethod})
      : colors = List<SwatchModel>.generate(length, (_) => SwatchModel()) {
    generateColors(genMethod);
  }

  ColorPalette({required this.colors});

  void setNumColors(int numColors, GenMethod genMethod) {
    colors = List<SwatchModel>.generate(length, (_) => SwatchModel());

    generateColors(genMethod);
  }

  Color getPaletteMedian() {
    var totalRed = 0;
    var totalBlue = 0;
    var totalGreen = 0;

    colors.forEach((element) {
      totalRed += element.color.red;
      totalBlue += element.color.blue;
      totalGreen += element.color.green;
    });

    var red = (totalRed / length).round();
    var green = (totalGreen / length).round();
    var blue = (totalBlue / length).round();

    return Color.fromARGB(255, red, green, blue);
  }

  void setGenMethod(GenMethod genMethod) {
    generateColors(genMethod);
  }

  ColorPalette copyWith({List<SwatchModel>? colors}) {
    var colorCopy = colors ?? this.colors;

    var tmp = ColorPalette(
      colors: List.generate(
          colorCopy.length, (index) => colorCopy[index].copywith()),
    );
    return tmp;
  }

  void generateColors(GenMethod genMethod) {
    var mix;
    switch (genMethod) {
      case GenMethod.pastel:
        mix = Colors.white;
        break;
      case GenMethod.median:
        mix = getPaletteMedian();
        break;
      default:
        break;
    }

    colors.where((element) {
      return !element.lock;
    }).forEach((element) {
      element.generateColor(mix: mix);
    });

    notifyListeners();
  }

  // Some settings don't require chaning data, but the display needs to be updated
  void forceUpdate() {
    notifyListeners();
  }

  @override
  bool operator ==(Object rhs) {
    return rhs is ColorPalette && listEquals(colors, rhs.colors);
  }

  @override
  int get hashCode => colors.hashCode;
}
