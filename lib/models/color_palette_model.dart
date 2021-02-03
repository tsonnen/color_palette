import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'swatch_model.dart';

enum GenMethod { rand, pastel, median }

class ColorPaletteModel extends ChangeNotifier {
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

  ColorPaletteModel clone() {
    var tmp = new ColorPaletteModel.fromJson(this.toJson());
    return tmp;
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

  // Some settings don't require chaning data, but the display needs to be updated
  void forceUpdate() {
    notifyListeners();
  }

  Map<String, dynamic> toJson() =>
      {'genMethod': genMethod.index, 'colors': jsonEncode(colors)};

  ColorPaletteModel.fromJson(Map<String, dynamic> json) {
    this._genMethod = GenMethod.values[json['genMethod']];
    this.colors = (jsonDecode(json['colors']) as List<dynamic>)
        .map((e) => SwatchModel.fromJson(e))
        .toList();
  }

  @override
  bool operator ==(Object rhs) {
    return rhs is ColorPaletteModel &&
        listEquals(colors, rhs.colors) &&
        genMethod == rhs.genMethod;
  }

  @override
  int get hashCode => colors.hashCode ^ genMethod.hashCode;
}
