// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.

import 'package:color_palette/models/color_palette_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Palette Model Test', () {
    setUp(() {});

    test('JSON end to end test', () async {
      var colorPaletteModel = ColorPaletteModel(1, GenMethod.rand);
      var json = colorPaletteModel.toJson();
      var fromJSON = ColorPaletteModel.fromJson(json);

      expect(fromJSON, colorPaletteModel);
    });
  });
}
