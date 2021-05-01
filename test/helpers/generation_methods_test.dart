import 'package:flutter_test/flutter_test.dart';

import 'package:color_palette/helpers/color_helper.dart';
import 'package:color_palette/models/swatch_model.dart';
import 'package:color_palette/services/generation_methods.dart';

void main() {
  group('Test mapping enum to generation methods', () {
    test('Map to PastelGenerationMethod', () {
      expect(GenerationMethod.mapEnum(GenMethodEnum.pastel),
          isA<PastelGenerationMethod>());
    });
    test('Map to MedianGenerationMethod', () {
      expect(GenerationMethod.mapEnum(GenMethodEnum.median),
          isA<MedianGenerationMethod>());
    });
    test('Map to RandomGenerationMethod', () {
      expect(GenerationMethod.mapEnum(GenMethodEnum.rand),
          isA<RandomGenerationMethod>());
    });
  });

  group('Test that generations are reasonable', () {
    List<SwatchModel> colors;

    setUp(() {
      colors = List<SwatchModel>.generate(
          10, (_) => SwatchModel(colorVal: ColorHelper.randomColor().value));

      test('Test pastel generation', () {
        var genMethod = PastelGenerationMethod();
        genMethod.Generate(colors).forEach((element) {
          expect(element.color.computeLuminance(), greaterThanOrEqualTo(.5));
        });
      });
      test('Test median generation', () {
        var genMethod = MedianGenerationMethod();
        var medianColor = ColorHelper.getSwatchListMedian(colors);
        genMethod.Generate(colors).forEach((element) {
          expect(
              element.color.red,
              inInclusiveRange(
                  medianColor.red ~/ 2, (medianColor.red + 255) ~/ 2));
          expect(
              element.color.blue,
              inInclusiveRange(
                  medianColor.blue ~/ 2, (medianColor.blue + 255) ~/ 2));
          expect(
              element.color.green,
              inInclusiveRange(
                  medianColor.green ~/ 2, (medianColor.green + 255) ~/ 2));
        });
      });
    });
  });
}
