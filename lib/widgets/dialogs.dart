import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return AlertDialog(
      title: Text('Enter a Name'),
      content: TextField(
        controller: nameController,
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.of(context).pop(nameController.text);
          },
        )
      ],
    );
  }
}

class ColorDialog extends StatefulWidget {
  final Color color;

  ColorDialog(this.color);

  @override
  ColorDialogState createState() => ColorDialogState();
}

class ColorDialogState extends State<ColorDialog> {
  var tmpColor;

  @override
  void initState() {
    tmpColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: tmpColor,
          onColorChanged: (color) {
            tmpColor = color;
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(widget.color);
          },
        ),
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop(tmpColor);
          },
        ),
      ],
    );
  }
}
