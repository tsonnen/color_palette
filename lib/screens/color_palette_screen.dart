import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_palette.dart';
import '../providers/color_text_provider.dart';
import '../services/color_palette_box.dart';
import '../widgets/app_drawer.dart';
import '../widgets/color_chip.dart';
import '../widgets/share_widget_helper.dart';

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
    var colorPaletteList = Provider.of<ColorPaletteBox>(context);
    var colorPaletteModel = Provider.of<ColorPalette>(context);
    var colorTextProvider = Provider.of<ColorTextProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Color Palette'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            ShareWidgetHelper.share(
                context: context, colorPalette: colorPaletteModel);
          },
        ),
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
                    colorTextProvider,
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
