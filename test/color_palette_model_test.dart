import 'package:color_palette/models/color_palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Palette Data Test', () {
    late ColorPalette colorPalette;

    setUp(() {
      colorPalette =
          ColorPalette.generated(length: 10, genMethod: GenMethod.pastel);
    });

    test('Copy with test', () async {
      var copied = colorPalette.copyWith();

      expect(colorPalette, copied);

      copied.setGenMethod(GenMethod.median);

      expect(colorPalette == copied, false);
    });

    test('Different swatch model instances', () {
      expect(colorPalette.colors.first == colorPalette.colors.last, false);
    });

    test('Test that number of colors changes', () async {
      expect(colorPalette.length, 10);

      colorPalette.setNumColors(5, GenMethod.median);

      expect(colorPalette.length, 5);
    });
  });
}
