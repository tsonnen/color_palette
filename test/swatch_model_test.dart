// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.

import 'dart:math';

import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Swatch Model Test', () {
    setUp(() {});

    test('Test copyWith', () async {
      var swatchModel = SwatchModel();
      var copied = swatchModel.copywith();

      expect(swatchModel, copied);

      copied.changeColor();

      expect(swatchModel == copied, false);
    });
  });
}
