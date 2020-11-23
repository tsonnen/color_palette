import 'package:flutter/widgets.dart';
import 'dart:math';

class ColorTile{
  bool lock = false;
  Color color;

  ColorTile(){
    generateColor();
  }

  void generateColor() {
    this.color = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}
