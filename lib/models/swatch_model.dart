import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'swatch_model.g.dart';

@HiveType(typeId: 1)
class SwatchModel {
  @HiveField(0)
  bool lock;

  @HiveField(1)
  int _colorVal;
  Color get color => Color(_colorVal);

  SwatchModel({this.lock = false, int colorVal = 0}) : _colorVal = colorVal;

  SwatchModel copywith({bool? lock, Color? color}) {
    return SwatchModel(
        lock: lock ?? this.lock, colorVal: color?.value ?? this.color.value);
  }

  void generateColor({Color? mix}) {
    var red = Random().nextInt(255);
    var green = Random().nextInt(255);
    var blue = Random().nextInt(255);

    if (mix != null) {
      red = ((red + mix.red) / 2).round();
      green = ((green + mix.green) / 2).round();
      blue = ((blue + mix.blue) / 2).round();
    }

    _colorVal = Color.fromARGB(255, red, green, blue).value;
  }

  @override
  bool operator ==(Object rhs) {
    return rhs is SwatchModel && lock == rhs.lock && color == rhs.color;
  }

  @override
  int get hashCode => lock.hashCode ^ color.hashCode;

  void setColor(Color color) {
    _colorVal = color.value;
  }
}
