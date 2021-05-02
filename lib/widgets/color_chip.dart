import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/swatch_model.dart';
import '../providers/color_text_provider.dart';
import '../widgets/dialogs.dart';

class ColorChip extends StatefulWidget {
  final SwatchModel swatchModel;
  final ColorTextProvider colorTextProvider;

  const ColorChip(this.swatchModel, this.colorTextProvider);

  @override
  ColorChipState createState() => ColorChipState();
}

class ColorChipState extends State<ColorChip> {
  @override
  Widget build(BuildContext context) {
    var swatchModel = widget.swatchModel;
    var textColor =
        swatchModel.color.computeLuminance() < .5 ? Colors.white : Colors.black;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: swatchModel.color,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(swatchModel.lock ? Icons.lock : Icons.lock_open),
            color: textColor,
            onPressed: () {
              setState(() {
                swatchModel.lock = !swatchModel.lock;
              });
            },
          ),
          Container(
            child: Text(
              widget.colorTextProvider.getText(swatchModel.color),
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
}
