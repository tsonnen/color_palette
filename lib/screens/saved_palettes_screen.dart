import 'package:color_palette/models/color_palette_model.dart';
import 'package:color_palette/models/listenable_map.dart';
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
    ListenableMap colorPaletteList = Provider.of<ListenableMap>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Palettes'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: colorPaletteList.keys.map((e) {
            ColorPaletteModel colorPalette = colorPaletteList[e];
            return Dismissible(
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              key: Key(e.hashCode.toString()),
              onDismissed: (direction) {
                setState(() {
                  colorPaletteList.remove(e);
                });

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("${colorPalette.name} dismissed")));
              },
              child: Container(
                child: Row(
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
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
