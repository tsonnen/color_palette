import 'dart:math';

import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';

enum GenMethodEnum { rand, pastel, median, hsl, lerp }

abstract class GenerationMethod {
  static GenerationMethod mapEnum(GenMethodEnum genMethodEnum) {
    switch (genMethodEnum) {
      case GenMethodEnum.median:
        return MedianGenerationMethod();
      case GenMethodEnum.pastel:
        return PastelGenerationMethod();
      case GenMethodEnum.rand:
        return RandomGenerationMethod();
      case GenMethodEnum.hsl:
        return HSLGenerationMethod();
      case GenMethodEnum.lerp:
        return LerpGenerationMethod();
      default:
        assert(false, 'Unknown Generation method');
        return RandomGenerationMethod();
    }
  }

  const GenerationMethod();

  List<Color> Generate(List<Color> colors);
}

class PastelGenerationMethod extends GenerationMethod {
  @override
  List<Color> Generate(List<Color> colors) {
    return List<Color>.generate(
        colors.length, (index) => ColorHelper.randomMixedColor(Colors.white));
  }
}

class MedianGenerationMethod extends GenerationMethod {
  @override
  List<Color> Generate(List<Color> colors) {
    var medianColor = ColorHelper.getColorListMedian(colors);

    return List<Color>.generate(
        colors.length, (index) => ColorHelper.randomMixedColor(medianColor));
  }
}

class RandomGenerationMethod extends GenerationMethod {
  const RandomGenerationMethod();

  @override
  List<Color> Generate(List<Color> colors) {
    return List<Color>.generate(
        colors.length, (index) => ColorHelper.randomColor());
  }
}

class HSLGenerationMethod extends GenerationMethod {
  @override
  List<Color> Generate(List<Color> colors) {
    return List<Color>.generate(
        colors.length,
        (index) => HSLColor.fromAHSL(1.0, (index * (360 / colors.length)),
                Random().nextDouble(), Random().nextDouble())
            .toColor());
  }
}

class LerpGenerationMethod extends GenerationMethod {
  @override
  List<Color> Generate(List<Color> colors) {
    var initialColor = HSLColor.fromColor(ColorHelper.randomColor());
    var finalColor = HSLColor.fromColor(ColorHelper.randomColor());
    return List<Color>.generate(
        colors.length,
        (index) =>
            HSLColor.lerp(initialColor, finalColor, index / colors.length)!
                .toColor());
  }
}
