import 'dart:math';

import 'package:flutter/material.dart';

class SwatchModel {
  bool lock;
  Color _color;
  Color get color => _color;

  SwatchModel({this.lock = false, int colorVal = 0}) {
    _color = Color(colorVal);
  }

  void getRandomColor({Color mix}) {
    var red = Random().nextInt(255);
    var green = Random().nextInt(255);
    var blue = Random().nextInt(255);

    if (mix != null) {
      red = ((red + mix.red) / 2).round();
      green = ((green + mix.green) / 2).round();
      blue = ((blue + mix.blue) / 2).round();
    }

    _color = Color.fromARGB(255, red, green, blue);
  }

  Map<String, dynamic> toJson() => {'lock': lock, 'color': color.value};

  SwatchModel.fromJson(Map<String, dynamic> json) {
    lock = json['lock'];
    _color = Color(json['color']);
  }

  @override
  bool operator ==(Object rhs) {
    return rhs is SwatchModel && lock == rhs.lock && color == rhs.color;
  }

  @override
  int get hashCode => lock.hashCode ^ color.hashCode;
}
