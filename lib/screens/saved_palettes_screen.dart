import 'package:color_palette/models/color_palette_model.dart';
import 'package:color_palette/models/listenable_list.dart';
import 'package:color_palette/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedPalettesScreen extends StatefulWidget {
  @override
  SavedPalettesScreenState createState() => SavedPalettesScreenState();
}

class SavedPalettesScreenState extends State<SavedPalettesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListenableList colorPaletteList =
        Provider.of<ListenableList<String, ColorPaletteModel>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Palettes'),
        ),
        body: Column(
          children: colorPaletteList.keys.map((e) {
            ColorPaletteModel colorPalette = colorPaletteList[e];
            return Row(
              children: colorPalette.colors
                  .map(
                    (e) => Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: e.color),
                        child: Text(""),
                      ),
                    ),
                  )
                  .toList(),
            );
          }).toList(),
        ));
  }
}
