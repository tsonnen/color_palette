import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/swatch_model.dart';
import '../widgets/dialogs.dart';

enum ColorText { hex, rgb }

class ColorChip extends StatefulWidget {
  final SwatchModel swatchModel;
  final ColorText colorText;

  const ColorChip(this.swatchModel, this.colorText);

  @override
  ColorChipState createState() => ColorChipState();
}

class ColorChipState extends State<ColorChip> {
  @override
  Widget build(BuildContext context) {
    var swatchModel = widget.swatchModel;
    var textColor = swatchModel.color!.computeLuminance() < .5
        ? Colors.white
        : Colors.black;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: swatchModel.color,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(swatchModel.lock! ? Icons.lock : Icons.lock_open),
            color: textColor,
            onPressed: () {
              setState(() {
                swatchModel.lock = !swatchModel.lock!;
              });
            },
          ),
          Container(
            child: Text(
              getText(swatchModel.color),
              style: TextStyle(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            color: textColor,
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ColorDialog(swatchModel.color);
                  }).then((value) {
                setState(() {
                  swatchModel.setColor(value);
                });
              });
            },
          ),
        ],
      ),
    );
  }

  String getText(Color? color) {
    switch (widget.colorText) {
      case ColorText.rgb:
        return '(${color!.red},${color.green},${color.blue})';
      case ColorText.hex:
        // remove the alpha value
        var tmp = color!.value & 16777215;
        return '#${tmp.toRadixString(16)}';
      default:
        return 'ERROR-PLEASE REPORT';
    }
  }
}
