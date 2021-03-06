import 'dart:ui';

import 'package:color_palette/services/preference_manager.dart';
import 'package:color_palette/widgets/color_chip.dart';
import 'package:color_palette/widgets/preference_widgets.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:preferences/preferences.dart';
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
      body: PreferencePage(
        [
          PreferenceTitle('Generation Method'),
          RadioPreference(
            'Random',
            GenMethod.rand.index,
            PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            isDefault: true,
            selected: true,
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.rand);
            },
          ),
          RadioPreference(
            'Pastel',
            GenMethod.pastel.index,
            PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.pastel);
            },
          ),
          RadioPreference(
            'Median',
            GenMethod.median.index,
            PreferenceManager.prefKeys[PrefTypes.GenMethod].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .setGenMethod(GenMethod.median);
            },
          ),
          PreferenceTitle('Number Colors'),
          FlatButton(
            onPressed: () {
              showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return NumberPickerDialog.integer(
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
          PreferenceTitle('Color Display'),
          RadioPreference(
            'Hexadecimal',
            ColorText.hex.index,
            PreferenceManager.prefKeys[PrefTypes.ColorText].toString(),
            isDefault: true,
            selected: true,
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .forceUpdate();
            },
          ),
          RadioPreference(
            'RGB',
            ColorText.rgb.index,
            PreferenceManager.prefKeys[PrefTypes.ColorText].toString(),
            onSelect: () {
              Provider.of<ColorPaletteModel>(context, listen: false)
                  .forceUpdate();
            },
          ),
          PreferenceTitle('Share Settings'),
          CheckboxPreference(
            'Show Share Options Dialog',
            PreferenceManager.prefKeys[PrefTypes.ShowShareOptionsDialog]
                .toString(),
          ),
          SwitchPreference(
            'Use Screen Size',
            PreferenceManager.prefKeys[PrefTypes.ShareUseScreenSize].toString(),
            defaultVal: PreferenceManager.getUseScreenSize(),
            onChange: () {
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
