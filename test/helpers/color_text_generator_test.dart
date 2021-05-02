import 'package:color_palette/helpers/color_helper.dart';
import 'package:color_palette/helpers/color_text_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Check text pattern', () {
    test('RGBText Generator match', () {
      var textGenerator = RGBTextGenerator();
      expect(textGenerator.getText(ColorHelper.randomColor()),
          matches(RegExp(r'rgb\([0-9]{1,3}\, [0-9]{1,3}\, [0-9]{1,3}\)')));
    });
    test('HexText Generator match', () {
      var textGenerator = HexTextGenerator();
      expect(textGenerator.getText(ColorHelper.randomColor()),
          matches(RegExp(r'#[0-9a-fA-F]{6}')));
    });
  });
}
