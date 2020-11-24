import 'package:color_palette/models/swatch_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatefulWidget{
  final SwatchModel swatchModel;

  const ColorChip(this.swatchModel);

  ColorChipState createState() => ColorChipState();
}

class ColorChipState extends State<ColorChip>{

  @override
  Widget build(BuildContext context) {
    SwatchModel swatchModel = widget.swatchModel;
    Color textColor =
        swatchModel.color.computeLuminance() < .5 ? Colors.white : Colors.black;
    return DecoratedBox(
        decoration: BoxDecoration(
          color: swatchModel.color,
        ),
        child: new Row(children: <Widget>[
          IconButton(
            icon: Icon(swatchModel.lock ? Icons.lock : Icons.lock_open),
            color: textColor,
            onPressed: () {
              setState(() {
                swatchModel.lock = !swatchModel.lock;
              });
            },
          ),
          new Container(
            child: Text(
              swatchModel.color.toString(),
              style: TextStyle(color: textColor),
              textAlign: TextAlign.center,
            ),
          )
        ]));
  }


}