import 'dart:ui';

import 'package:color_palette/services/preference_manager.dart';
import 'package:color_palette/widgets/color_chip.dart';
import 'package:color_palette/widgets/numberpicker_dialog.dart';
import 'package:color_palette/widgets/preference_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import '../models/color_palette_model.dart';

class SettingsPage extends StatefulWidget {
  static final String route = 'Settings-Page';

  SettingsPage();

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  var shareWidthController = TextEditingController();
  var shareHeightController = TextEditingController();

  @override
  void initState() {
    shareHeightController.text = PreferenceManager.getShareHeight().toString();
    shareWidthController.text = PreferenceManager.getShareWidth().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: PrefPage(
        children: [
          PrefTitle(title: Text('Generation Method')),
          PrefRadio(
            title: Text('Random'),
            value: GenMethod.rand.index,
            pref: PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            selected: true,
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.rand);
            },
          ),
          PrefRadio(
            title: Text('Pastel'),
            value: GenMethod.pastel.index,
            pref: PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.pastel);
            },
          ),
          PrefRadio(
            title: Text('Median'),
            value: GenMethod.median.index,
            pref: PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.median);
            },
          ),
          PrefTitle(title: Text('Number Colors')),
          TextButton(
            onPressed: () {
              showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return NumberPickerDialog(
                      minValue: 1,
                      maxValue: 10,
                      initialIntegerValue: PreferenceManager.getNumColors(),
                    );
                  }).then((value) {
                setState(() {
                  if (value != null) {
                    PreferenceManager.setNumColors(value);
                    Provider.of<ColorPaletteModel>(context, listen: false)
                        .setNumColors(value);
                  }
                });
              });
            },
            child: Text('${PreferenceManager.getNumColors()}'),
          ),
          PrefTitle(title: Text('Color Display')),
          PrefRadio(
            title: Text('Hexadecimal'),
            value: ColorText.hex.index,
            pref: PreferenceManager.prefKeys[PrefTypes.ColorText].toString(),
            selected: true,
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .forceUpdate();
            },
          ),
          PrefRadio(
            title: Text('RGB'),
            value: ColorText.rgb.index,
            pref: PreferenceManager.prefKeys[PrefTypes.ColorText].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .forceUpdate();
            },
          ),
          PrefTitle(title: Text('Share Settings')),
          PrefCheckbox(
            title: Text('Show Share Options Dialog'),
            pref: PreferenceManager.prefKeys[PrefTypes.ShowShareOptionsDialog]
                .toString(),
          ),
          PrefSwitch(
            title: Text('Use Screen Size'),
            pref: PreferenceManager.prefKeys[PrefTypes.ShareUseScreenSize]
                .toString(),
            onChange: (val) {
              setState(() {
                if (PreferenceManager.getUseScreenSize()) {
                  PreferenceManager.setShareHeight(
                      window.physicalSize.height.toInt());
                  shareHeightController.text =
                      PreferenceManager.getShareHeight().toString();
                  PreferenceManager.setShareWidth(
                      window.physicalSize.width.toInt());
                  shareWidthController.text =
                      PreferenceManager.getShareWidth().toString();
                }
              });
            },
          ),
          Row(
            children: [
              PreferenceNumericField(
                'Width (px)',
                PreferenceManager.prefKeys[PrefTypes.ShareWidth].toString(),
                enabled: !PreferenceManager.getUseScreenSize(),
                defaultVal: PreferenceManager.getShareWidth().toString(),
                controller: shareWidthController,
              ),
              PreferenceNumericField(
                'Height (px)',
                PreferenceManager.prefKeys[PrefTypes.ShareHeight].toString(),
                enabled: !PreferenceManager.getUseScreenSize(),
                defaultVal: PreferenceManager.getShareHeight().toString(),
                controller: shareHeightController,
              )
            ],
          ),
        ],
      ),
    );
  }
}
