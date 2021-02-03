// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.

import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Swatch Model Test", () {
    setUp(() {});

    test("JSON end to end test", () async {
      var swatchModel = new SwatchModel();
      swatchModel.getRandomColor();
      var json = swatchModel.toJson();
      var fromJSON = SwatchModel.fromJson(json);

      expect(fromJSON, swatchModel);
    });
  });
}
