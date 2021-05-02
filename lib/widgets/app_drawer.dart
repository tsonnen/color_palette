import 'package:flutter/material.dart';

import '../screens/saved_palettes_screen.dart';
import '../screens/preferences_screen.dart';

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
                    builder: (context) => PreferencesScreen(),
                  ),
                );
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
