import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_palette_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palette'),
      ),
      drawer: AppDrawer(),
      body: Consumer<ColorPaletteModel>(
          builder: (context, colorPaletteModel, child) {
        return Column(
          children: colorPaletteModel.colors
              .map((e) => Expanded(child: ColorChip(e)))
              .toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ColorPaletteModel>(context, listen: false)
              .generateColors();
        },
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
