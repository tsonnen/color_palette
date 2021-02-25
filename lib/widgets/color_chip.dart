import 'package:color_palette/models/swatch_model.dart';
import 'package:color_palette/services/preference_manager.dart';
import 'package:color_palette/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColorText { hex, rgb }

class ColorChip extends StatefulWidget {
  final SwatchModel swatchModel;

  const ColorChip(this.swatchModel);

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

  String getText(Color color) {
    switch (PreferenceManager.getColorText()) {
      case ColorText.rgb:
        return '(${color.red},${color.green},${color.blue})';
      case ColorText.hex:
        // remove the alpha value
        var tmp = color.value & 16777215;
        return '#${tmp.toRadixString(16)}';
      default:
        return 'ERROR-PLEASE REPORT';
    }
  }
}
