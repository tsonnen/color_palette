import 'package:flutter/material.dart';

import '../helpers/color_text_generator.dart';

class ColorTextProvider extends ChangeNotifier {
  ColorTextGenerator colorTextGenerator;

  ColorTextProvider(this.colorTextGenerator);

  void changeTextGenerator(ColorTextGenerator colorTextGenerator) {
    this.colorTextGenerator = colorTextGenerator;
    notifyListeners();
  }

  String getText(Color color) {
    return colorTextGenerator.getText(color);
  }
}
