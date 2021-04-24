import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/color_palette_model.dart';
import '../models/listenable_map.dart';
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
    var colorPaletteList = Provider.of<ListenableMap>(context);
    var colorPaletteModel = Provider.of<ColorPaletteModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Color Palette'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            colorPaletteList[Uuid().v4()] = colorPaletteModel.copy();
          },
        ),
      ]),
      drawer: AppDrawer(),
      body: Consumer<ColorPaletteModel>(
          builder: (context, colorPaletteModel, child) {
        return Column(
          children: colorPaletteModel.colors
              .map(
                (e) => Expanded(
                  child: ColorChip(
                    e,
                    PrefManager.getColorText(PrefService.of(context)),
                  ),
                ),
              )
              .toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ColorPaletteModel>(context, listen: false)
              .generateColors();
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
