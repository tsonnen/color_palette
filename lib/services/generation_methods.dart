import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';
import '../models/swatch_model.dart';

enum GenMethodEnum { rand, pastel, median }

abstract class GenerationMethod {
  static GenerationMethod mapEnum(GenMethodEnum genMethodEnum) {
    switch (genMethodEnum) {
      case GenMethodEnum.median:
        return MedianGenerationMethod();
      case GenMethodEnum.pastel:
        return PastelGenerationMethod();
      case GenMethodEnum.rand:
        return RandomGenerationMethod();
      default:
        assert(false, 'Unknown Generation method');
        return RandomGenerationMethod();
    }
  }

  const GenerationMethod();

  List<SwatchModel> Generate(List<SwatchModel> colors);
}

class PastelGenerationMethod extends GenerationMethod {
  @override
  List<SwatchModel> Generate(List<SwatchModel> colors) {
    return List<SwatchModel>.generate(
        colors.length,
        (_) => SwatchModel(
            colorVal: ColorHelper.randomMixedColor(Colors.white).value));
  }
}

class MedianGenerationMethod extends GenerationMethod {
  @override
  List<SwatchModel> Generate(List<SwatchModel> colors) {
    var medianColor = ColorHelper.getSwatchListMedian(colors);

    return List<SwatchModel>.generate(
        colors.length,
        (_) => SwatchModel(
            colorVal: ColorHelper.randomMixedColor(medianColor).value));
  }
}

class RandomGenerationMethod extends GenerationMethod {
  const RandomGenerationMethod();

  @override
  List<SwatchModel> Generate(List<SwatchModel> colors) {
    return List<SwatchModel>.generate(colors.length,
        (_) => SwatchModel(colorVal: ColorHelper.randomColor().value));
  }
}
