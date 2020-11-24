import 'package:color_palette/models/color_palette_model.dart';
import 'package:color_palette/widgets/color_chip.dart';
import 'package:flutter/material.dart';

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
      new ColorPaletteModel(5, genMethod: GenMethod.median);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Palette"),
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
