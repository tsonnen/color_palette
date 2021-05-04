import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../helpers/app_info.dart';
import '../screens/preferences_screen.dart';
import '../screens/saved_palettes_screen.dart';

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
              },),


        if (!kIsWeb)
            AboutListTile(
              applicationName: 'Color Palette',
              icon: Icon(Icons.info),
              applicationIcon: Image.asset(
                'assets/images/app_image.png',
               scale: 5, 
              ),
              applicationVersion: AppInfo.version,
              applicationLegalese: '\u{a9} 2021',
              aboutBoxChildren: [
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          text: 'This is a simple color palette generator. Please'
                              ' send any questions or suggestions to '),
                      TextSpan(
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch('mailto:tsonnenapps@gmail.com');
                            },
                          text: 'tsonnenapps@gmail.com'),
                      TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          text: '.'),
                    ],
                  ),
                ),
               ] ),] ),);
  }
}
