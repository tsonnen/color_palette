import 'package:color_palette/models/color_palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Palette Data Test', () {
    setUp(() {});

    test('Copy with test', () async {
      var colorPalette =
          ColorPalette.generated(length: 10, genMethod: GenMethod.pastel);

      var copied = colorPalette.copyWith();

      expect(colorPalette, copied);

      copied.setGenMethod(GenMethod.median);

      expect(colorPalette == copied, false);
    });

    test('Different swatch model instances', () {
      var colorPalette =
          ColorPalette.generated(length: 10, genMethod: GenMethod.pastel);
      expect(colorPalette.colors.first == colorPalette.colors.last, false);
    });
  });
}
