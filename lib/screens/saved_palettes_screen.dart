import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import '../services/color_palette_box.dart';
import '../services/preference_manager.dart';
import '../helpers/share_helper.dart';
import '../widgets/dialogs.dart';
import '../widgets/dismissable_background.dart';

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
    var service = PrefService.of(context);
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
                } else if (direction == DismissDirection.endToStart) {
                  if (PrefManager.getShowShareOptionsDialog(service)) {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShareOptionsDialog(colorPalette);
                        });
                  } else {
                    await ShareHelper.sharePalette(
                        colorPalette,
                        Size(PrefManager.getShareWidth(service).toDouble(),
                            PrefManager.getShareHeight(service).toDouble()));
                  }
                  return false;
                }

                return null;
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
