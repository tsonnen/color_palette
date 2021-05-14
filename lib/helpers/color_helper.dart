import 'dart:math';

import 'package:flutter/material.dart';

import '../models/swatch_model.dart';

class ColorHelper {
  static Color getSwatchListMedian(List<SwatchModel> colors) {
    return getColorListMedian(colors.map((e) => e.color).toList());
  }

  static Color getColorListMedian(List<Color> colors) {
    if (colors.isEmpty) return ColorHelper.randomColor();

    var length = colors.length;

    var totalRed = 0;
    var totalBlue = 0;
    var totalGreen = 0;

    colors.forEach((element) {
      totalRed += element.red;
      totalBlue += element.blue;
      totalGreen += element.green;
    });

    var red = (totalRed / length).round();
    var green = (totalGreen / length).round();
    var blue = (totalBlue / length).round();

    return Color.fromARGB(255, red, green, blue);
  }

  static Color randomColor() {
    var red = Random().nextInt(255);
    var green = Random().nextInt(255);
    var blue = Random().nextInt(255);

    return Color.fromARGB(255, red, green, blue);
  }

  static Color randomMixedColor(Color mix) {
    var color = randomColor();

    var red = ((color.red + mix.red) / 2).round();
    var green = ((color.green + mix.green) / 2).round();
    var blue = ((color.blue + mix.blue) / 2).round();

    return Color.fromARGB(255, red, green, blue);
  }
}
