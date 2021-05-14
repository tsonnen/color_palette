import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:color_palette/helpers/color_helper.dart';
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
    List<Color> colors;

    setUp(() {
      colors = List<Color>.generate(10, (_) => ColorHelper.randomColor());

      test('Test pastel generation', () {
        var genMethod = PastelGenerationMethod();
        genMethod.Generate(colors).forEach((element) {
          expect(element.computeLuminance(), greaterThanOrEqualTo(.5));
        });
      });
      test('Test median generation', () {
        var genMethod = MedianGenerationMethod();
        var medianColor = ColorHelper.getColorListMedian(colors);
        genMethod.Generate(colors).forEach((element) {
          expect(
              element.red,
              inInclusiveRange(
                  medianColor.red ~/ 2, (medianColor.red + 255) ~/ 2));
          expect(
              element.blue,
              inInclusiveRange(
                  medianColor.blue ~/ 2, (medianColor.blue + 255) ~/ 2));
          expect(
              element.green,
              inInclusiveRange(
                  medianColor.green ~/ 2, (medianColor.green + 255) ~/ 2));
        });
      });
    });
  });
}
