import 'package:flutter/material.dart';

enum ColorTextEnum { hex, rgb }

abstract class ColorTextGenerator {
  static ColorTextGenerator mapEnum(ColorTextEnum colorTextEnum) {
    switch (colorTextEnum) {
      case ColorTextEnum.hex:
        return HexTextGenerator();
      case ColorTextEnum.rgb:
        return RGBTextGenerator();
      default:
        assert(false, 'Unknown Color Text Generation');
        return RGBTextGenerator();
    }
  }

  String getText(Color color);
}

class RGBTextGenerator extends ColorTextGenerator {
  @override
  String getText(Color color) {
    return 'rgb(${color.red}, ${color.green}, ${color.green})';
  }
}

class HexTextGenerator extends ColorTextGenerator {
  @override
  String getText(Color color) {
    // remove the alpha value
    var tmp = color.value & 16777215;
    return '#${tmp.toRadixString(16)}';
  }
}
