import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pref/pref.dart';

import 'expanded_text_field.dart';
import 'input_widgets.dart';
import '../models/color_palette.dart';
import '../helpers/share_helper.dart';
import '../helpers/color_text_generator.dart';
import '../providers/color_text_provider.dart';
import '../services/preference_manager.dart';

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
  State<ShareOptionsDialog> createState() => _ShareOptionsDialogState();
}

class _ShareOptionsDialogState extends State<ShareOptionsDialog> {
  late bool useScreenSize;
  var shareWidthController = TextEditingController();
  var shareHeightController = TextEditingController();
  late ColorTextEnum colorTextEnum;

  @override
  void didChangeDependencies() {
    var service = PrefService.of(context);
    useScreenSize = PrefManager.getUseScreenSize(service);
    shareWidthController.text = PrefManager.getShareWidth(service).toString();
    shareHeightController.text = PrefManager.getShareHeight(service).toString();
    super.didChangeDependencies();
    colorTextEnum = PrefManager.getColorText(service);
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
            Text('Size Options',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: Theme.of(context).accentColor)),
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
                ExpandedTextField.numeric(
                  enabled: !useScreenSize,
                  controller: shareWidthController,
                  label: 'Width (px)',
                ),
                ExpandedTextField.numeric(
                  enabled: !useScreenSize,
                  controller: shareHeightController,
                  label: 'Height (px)',
                ),
              ],
            ),
            Text('Color Display',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: Theme.of(context).accentColor)),
            LabeledInput(
              label: 'Hexadecimal',
              widget: Radio(
                  value: ColorTextEnum.hex,
                  groupValue: colorTextEnum,
                  onChanged: _handleChange),
            ),
            LabeledInput(
              label: 'RGB',
              widget: Radio(
                  value: ColorTextEnum.rgb,
                  groupValue: colorTextEnum,
                  onChanged: _handleChange),
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
                colorPalette: widget.palette,
                size: Size(double.tryParse(shareWidthController.text)!,
                    double.tryParse(shareHeightController.text)!),
                colorTextProvider: ColorTextProvider(
                    ColorTextGenerator.mapEnum(colorTextEnum)));
            Navigator.of(context).pop();
          },
          child: Text('Share!'),
        ),
      ],
    );
  }

  void _handleChange(ColorTextEnum? value) {
    setState(() {
      colorTextEnum = value!;
    });
  }
}
