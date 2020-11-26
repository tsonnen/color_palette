import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter/material.dart';

enum GenMethod { rand, pastel, median }

class ColorPaletteModel extends ChangeNotifier{
  List<SwatchModel> colors = <SwatchModel>[];
  GenMethod _genMethod;
  GenMethod get genMethod => _genMethod;

  ColorPaletteModel(length, this._genMethod) {
    for (var i = 0; i < length; ++i) {
      colors.add(SwatchModel());
    }

    generateColors();
  }

  void setGenMethod(GenMethod newMethod) {
    _genMethod = newMethod;

    generateColors();
  }

  void setNumColors(int numColors) {
    colors.clear();

     for (var i = 0; i < numColors; ++i) {
      colors.add(SwatchModel());
    }

    generateColors();
  }


  Color getPaletteMedian() {
    var totalRed = 0;
    var totalBlue = 0;
    var totalGreen = 0;

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

    var red = (totalRed / countedColors).round();
    var green = (totalGreen / countedColors).round();
    var blue = (totalBlue / countedColors).round();

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

    notifyListeners();
  }
}
