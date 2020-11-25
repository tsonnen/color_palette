import 'package:color_palette/models/color_palette_model.dart';
import 'package:color_palette/services/preference_manager.dart';
import 'package:color_palette/widgets/color_chip.dart';
import 'package:flutter/material.dart';

import 'settings_screen.dart';

class ColorPaletteScreen extends StatefulWidget {
  ColorPaletteScreen();

  ColorPaletteScreenState createState() => ColorPaletteScreenState();
}

class ColorPaletteScreenState extends State<ColorPaletteScreen> {
  ColorPaletteModel colorPallete;

  @override
  void initState() {
    super.initState();
     colorPallete =
      new ColorPaletteModel(5, PreferenceManger.getGenMethod());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Palette"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Color Palette"),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(colorPallete),
                    ),
                  );
                }),
          ],
        ),
      ),
      body: Column(
        children: colorPallete.colors
            .map((e) => Expanded(child: ColorChip(e)))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            colorPallete.generateColors();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
