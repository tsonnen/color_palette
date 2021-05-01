import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pref/pref.dart';

import '../models/color_palette.dart';
import '../services/preference_manager.dart';
import '../helpers/share_helper.dart';
import '../widgets/input_widgets.dart';

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
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(nameController.text);
          },
          child: Text('Save'),
        )
      ],
    );
  }
}

class ColorDialog extends StatefulWidget {
  final Color? color;

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
          enableAlpha: false,
          pickerColor: tmpColor,
          onColorChanged: (color) {
            tmpColor = color;
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(widget.color);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(tmpColor);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}

class ShareOptionsDialog extends StatefulWidget {
  final ColorPalette palette;

  ShareOptionsDialog(this.palette);
  @override
  State<ShareOptionsDialog> createState() => ShareOptionsDialogState();
}

class ShareOptionsDialogState extends State<ShareOptionsDialog> {
  late bool useScreenSize;
  var shareWidthController = TextEditingController();
  var shareHeightController = TextEditingController();

  @override
  void didChangeDependencies() {
    useScreenSize = PrefManager.getUseScreenSize(PrefService.of(context));
    shareWidthController.text =
        PrefManager.getShareWidth(PrefService.of(context)).toString();
    shareHeightController.text =
        PrefManager.getShareHeight(PrefService.of(context)).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Share Options'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            LabeledInput.Switch(
              label: 'Use Screen Size',
              value: useScreenSize,
              onChanged: (val) {
                setState(() {
                  useScreenSize = val;
                  shareHeightController.text =
                      window.physicalSize.height.toInt().toString();
                  shareWidthController.text =
                      window.physicalSize.width.toInt().toString();
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      enabled: !useScreenSize,
                      controller: shareWidthController,
                      decoration: InputDecoration(
                          labelText: 'Width (px)',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      enabled: !useScreenSize,
                      controller: shareHeightController,
                      decoration: InputDecoration(
                          labelText: 'Height (px)',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await ShareHelper.sharePalette(
                widget.palette,
                Size(double.tryParse(shareWidthController.text)!,
                    double.tryParse(shareHeightController.text)!));
            Navigator.of(context).pop();
          },
          child: Text('Share!'),
        ),
      ],
    );
  }
}
