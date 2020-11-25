import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../models/color_palette_model.dart';

class SettingsPage extends StatefulWidget {
  static final String route = 'Settings-Page';
  final ColorPaletteModel colorPalette;

  SettingsPage(this.colorPalette);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
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
            'gen_method',
            isDefault: true,
            onSelect: () {
              widget.colorPalette.setGenMethod(GenMethod.rand);
            },
          ),
          RadioPreference(
            'Pastel',
            GenMethod.pastel.index,
            'gen_method',
            onSelect: () {
              widget.colorPalette.setGenMethod(GenMethod.pastel);
            },
          ),
          RadioPreference(
            'Median',
            GenMethod.median.index,
            'gen_method',
            onSelect: () {
              widget.colorPalette.setGenMethod(GenMethod.median);
            },
          ),
        ],
      ),
    );
  }
}
