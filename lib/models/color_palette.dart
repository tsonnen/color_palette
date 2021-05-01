import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../services/generation_methods.dart';
import 'swatch_model.dart';

part 'color_palette.g.dart';

@HiveType(typeId: 0)
class ColorPalette extends ChangeNotifier {
  @HiveField(0)
  late List<SwatchModel> colors;

  GenerationMethod generationMethod;

  int get length => colors.length;

  ColorPalette.generated({required int length, required this.generationMethod})
      : colors = List<SwatchModel>.generate(length, (_) => SwatchModel()) {
    generateColors();
  }

  ColorPalette(
      {required this.colors,
      this.generationMethod = const RandomGenerationMethod()});

  void setNumColors(int numColors) {
    colors = List<SwatchModel>.generate(numColors, (_) => SwatchModel());

    generateColors();
  }

  void setGenMethod(GenerationMethod generationMethod) {
    this.generationMethod = generationMethod;
    generateColors();
  }

  ColorPalette copyWith({List<SwatchModel>? colors}) {
    var colorCopy = colors ?? this.colors;

    var tmp = ColorPalette(
      colors: List.generate(
          colorCopy.length, (index) => colorCopy[index].copywith()),
    );
    return tmp;
  }

  void generateColors() {
    colors = generationMethod.Generate(colors);

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
