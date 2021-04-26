import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import '../models/color_palette.dart';
import '../services/preference_manager.dart';
import '../widgets/color_chip.dart';
import '../widgets/numberpicker_dialog.dart';

class SettingsScreen extends StatefulWidget {
  static final String route = 'Settings-Page';

  SettingsScreen();

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var service = PrefService.of(context);
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
            pref: PrefManager.GenMethodKey,
            selected: true,
            onSelect: () {
              Provider.of<ColorPalette>(context, listen: false)
                  .setGenMethod(GenMethod.rand);
            },
          ),
          PrefRadio(
            title: Text('Pastel'),
            value: GenMethod.pastel.index,
            pref: PrefManager.GenMethodKey,
            onSelect: () {
              Provider.of<ColorPalette>(context, listen: false)
                  .setGenMethod(GenMethod.pastel);
            },
          ),
          PrefRadio(
            title: Text('Median'),
            value: GenMethod.median.index,
            pref: PrefManager.GenMethodKey,
            onSelect: () {
              Provider.of<ColorPalette>(context, listen: false)
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
                      initialIntegerValue: PrefManager.getNumColors(service),
                    );
                  }).then((value) {
                setState(() {
                  if (value != null) {
                    PrefManager.setNumColors(value, service);
                    Provider.of<ColorPalette>(context, listen: false)
                        .setNumColors(value, PrefManager.getGenMethod(service));
                  }
                });
              });
            },
            child: Text('${PrefManager.getNumColors(service)}'),
          ),
          PrefTitle(title: Text('Color Display')),
          PrefRadio(
            title: Text('Hexadecimal'),
            value: ColorText.hex.index,
            pref: PrefManager.ColorTextKey,
            selected: true,
            onSelect: () {
              Provider.of<ColorPalette>(context, listen: false).forceUpdate();
            },
          ),
          PrefRadio(
            title: Text('RGB'),
            value: ColorText.rgb.index,
            pref: PrefManager.ColorTextKey,
            onSelect: () {
              Provider.of<ColorPalette>(context, listen: false).forceUpdate();
            },
          ),
          PrefTitle(title: Text('Share Settings')),
          PrefCheckbox(
            title: Text('Show Share Options Dialog'),
            pref: PrefManager.ShowShareOptionsKey,
          ),
          PrefSwitch(
            title: Text('Use Screen Size'),
            pref: PrefManager.ShareUseScreenSizeKey,
            onChange: (val) {
              setState(() {
                if (PrefManager.getUseScreenSize(service)) {
                  PrefManager.setShareHeight(
                      window.physicalSize.height.toInt(), service);
                  PrefManager.setShareWidth(
                      window.physicalSize.width.toInt(), service);
                }
              });
            },
          ),
          PrefText(
            pref: PrefManager.ShareWidthKey,
            label: 'Width (px)',
            disabled: PrefManager.getUseScreenSize(service),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          PrefText(
            pref: PrefManager.ShareHeightKey,
            label: 'Height (px)',
            disabled: PrefManager.getUseScreenSize(service),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
    );
  }
}
