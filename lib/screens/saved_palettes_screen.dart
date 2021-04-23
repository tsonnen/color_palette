import 'package:color_palette/models/listenable_map.dart';
import 'package:color_palette/services/preference_manager.dart';
import 'package:color_palette/services/share_helper.dart';
import 'package:color_palette/widgets/dialogs.dart';
import 'package:color_palette/widgets/dismissable_background.dart';
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
    var colorPaletteList = Provider.of<ListenableMap>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Palettes'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: colorPaletteList.keys.map((e) {
            var colorPalette = colorPaletteList[e]!;
            return Dismissible(
              key: Key(e.hashCode.toString()),
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
                    colorPaletteList.remove(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Palette removed')));
                  });
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  return true;
                } else if (direction == DismissDirection.endToStart) {
                  if (PreferenceManager.getShowShareOptionsDialog()) {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShareOptionsDialog(colorPalette);
                        });
                  } else {
                    await ShareHelper.sharePalette(
                        colorPalette,
                        Size(PreferenceManager.getShareWidth().toDouble(),
                            PreferenceManager.getShareHeight().toDouble()));
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
