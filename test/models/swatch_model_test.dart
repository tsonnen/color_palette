import 'package:flutter_test/flutter_test.dart';

import 'package:color_palette/models/swatch_model.dart';

void main() {
  group('Swatch Model Test', () {
    setUp(() {});

    test('Test copyWith', () async {
      var swatchModel = SwatchModel();
      var copied = swatchModel.copywith();

      expect(swatchModel, copied);

      copied.generateColor();

      expect(swatchModel == copied, false);
    });
  });
}
