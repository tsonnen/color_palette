import 'package:color_palette/screens/saved_palettes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'dialogs.dart';
import '../models/color_palette_model.dart';
import '../models/listenable_map.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorPaletteList =
        Provider.of<ListenableMap>(context);
    var colorPaletteModel = Provider.of<ColorPaletteModel>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Color Palette'),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.save),
              title: Text('Save Palette'),
              onTap: () {
                Navigator.of(context).pop();

                showDialog<String>(
                    context: context,
                    builder: (context) {
                      return NameDialog();
                    }).then((value) {
                  if (value != null) {
                    colorPaletteModel.setName(value);
                    colorPaletteList[Uuid().v4()] = colorPaletteModel;
                  }
                });
              }),
          ListTile(
              title: Text('Saved Palette'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SavedPalettesScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
