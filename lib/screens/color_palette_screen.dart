import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import '../models/color_palette.dart';
import '../services/color_palette_box.dart';
import '../services/preference_manager.dart';
import '../widgets/app_drawer.dart';
import '../widgets/color_chip.dart';

class ColorPaletteScreen extends StatefulWidget {
  ColorPaletteScreen();

  @override
  ColorPaletteScreenState createState() => ColorPaletteScreenState();
}

class ColorPaletteScreenState extends State<ColorPaletteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var service = PrefService.of(context);
    var colorPaletteList = Provider.of<ColorPaletteBox>(context);
    var colorPaletteModel = Provider.of<ColorPalette>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Color Palette'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            colorPaletteList.addColorPalette(colorPaletteModel.copyWith());
          },
        ),
      ]),
      drawer: AppDrawer(),
      body:
          Consumer<ColorPalette>(builder: (context, colorPaletteModel, child) {
        return Column(
          children: colorPaletteModel.colors
              .map(
                (e) => Expanded(
                  child: ColorChip(
                    e,
                    PrefManager.getColorText(service),
                  ),
                ),
              )
              .toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ColorPalette>(context, listen: false).generateColors();
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
