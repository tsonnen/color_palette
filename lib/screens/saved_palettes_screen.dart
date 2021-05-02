import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/color_palette_box.dart';
import '../widgets/dismissable_background.dart';
import '../widgets/share_widget_helper.dart';

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
    var colorPaletteList = Provider.of<ColorPaletteBox>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Palettes'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: colorPaletteList.colorPalettes.map((colorPalette) {
            return Dismissible(
              key: Key(colorPalette.hashCode.toString()),
              background: DismissableBackground(
                  icon: Icons.delete,
                  text: 'Delete',
                  backgroundColor: Colors.red,
                  align: BackgroundType.PRIMARY),
              secondaryBackground: DismissableBackground(
                  icon: Icons.share,
                  text: 'Share',
                  backgroundColor: Colors.blue,
                  align: BackgroundType.SECONDARY),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    colorPaletteList.deleteColorPalette(colorPalette);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Palette removed')));
                  });
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  return true;
                }
                ShareWidgetHelper.share(
                    context: context, colorPalette: colorPalette);
                return false;
              },
              child: Container(
                height: 50.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: colorPalette.colors
                      .map(
                        (e) => Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: e.color),
                            child: Text(''),
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
