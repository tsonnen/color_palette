import 'dart:math';

import 'package:flutter/material.dart';

class SwatchModel{
  bool lock = false;
  Color _color;
  Color get color => _color;

  SwatchModel();

  void getRandomColor({Color mix}){
    var red =  Random().nextInt(255);
    var green = Random().nextInt(255);
    var blue = Random().nextInt(255);

    if(mix != null){
      red = ((red + mix.red)/2).round();
      green = ((green + mix.green)/2).round();
      blue = ((blue + mix.blue)/2).round();
    }

    this._color = Color.fromARGB(255, red, green, blue);
  }
}