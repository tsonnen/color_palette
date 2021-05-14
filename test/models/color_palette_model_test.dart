import 'package:color_palette/helpers/color_helper.dart';
import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:color_palette/models/color_palette.dart';
import 'package:color_palette/services/generation_methods.dart';

void main() {
  group('Color Palette Data Test', () {
    late ColorPalette colorPalette;

    setUp(() {
      colorPalette = ColorPalette.generated(
          length: 10,
          generationMethod: GenerationMethod.mapEnum(GenMethodEnum.pastel));
    });

    test('Copy with test', () async {
      var copied = colorPalette.copyWith();

      expect(colorPalette, copied);

      copied.setGenMethod(MedianGenerationMethod());

      expect(colorPalette == copied, false);
    });

    test('Different swatch model instances', () {
      expect(colorPalette.colors.first == colorPalette.colors.last, false);
    });

    test('Test that number of colors changes', () async {
      expect(colorPalette.length, 10);

      colorPalette.setNumColors(5);

      expect(colorPalette.length, 5);
    });

    test('Expect that locked colors do not change', () {
      var colors = List<SwatchModel>.generate(
        10,
        (index) => SwatchModel(
            colorVal: ColorHelper.randomColor().value, lock: index % 2 == 0),
      );

      colorPalette.colors =
          List<SwatchModel>.generate(colors.length, (index) => colors[index]);

      colorPalette.generateColors();

      colorPalette.colors.forEach((element) {
        var index = colorPalette.colors.indexOf(element);
        if (index % 2 == 0) {
          expect(element, colors[index]);
        }
      });
    });
  });
}
