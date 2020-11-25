import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter/material.dart';

enum GenMethod { rand, pastel, median }

class ColorPaletteModel {
  List<SwatchModel> colors = List<SwatchModel>();
  GenMethod _genMethod;
  GenMethod get genMethod => _genMethod;

  ColorPaletteModel(length, _genMethod) {
    for (var i = 0; i < length; ++i) {
      colors.add(new SwatchModel());
    }

    generateColors();
  }

  void setGenMethod(GenMethod newMethod) {
    _genMethod = newMethod;

    generateColors();
  }

  Color getPaletteMedian() {
    int totalRed = 0;
    int totalBlue = 0;
    int totalGreen = 0;

    var countedColors = colors.length;

    colors.forEach((element) {
      var elementColor = element?.color;

      if (elementColor == null) {
        --countedColors;
        return;
      }

      totalRed += element.color.red;
      totalBlue += element.color.blue;
      totalGreen += element.color.green;
    });

    if (countedColors == 0) {
      return null;
    }

    int red = (totalRed / countedColors).round();
    int green = (totalGreen / countedColors).round();
    int blue = (totalBlue / countedColors).round();

    return Color.fromARGB(255, red, green, blue);
  }

  void generateColors() {
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
      return !(element?.lock ?? false);
    }).forEach((element) {
      element?.getRandomColor(mix: mix);
    });
  }
}
