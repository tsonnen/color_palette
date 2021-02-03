import 'dart:io';
import 'dart:typed_data';

import 'package:color_palette/models/color_palette_model.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ShareHelper {
  static Future<void> shareImage(Image image) async {
    final Uint8List list = encodePng(image);

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);

    await Share.shareFiles(
      ['${tempDir.path}/image.jpg'],
      subject: "share it!",
      text: "share flutter",
    );
  }

  static Image paletteToImage(ColorPaletteModel colorPaletteModel) {
    int chipHeight = 50;
    int width = 100;
    int height = chipHeight * colorPaletteModel.colors.length;
    var image = Image(width, height);

    colorPaletteModel.colors.forEach((m) {
      int y = colorPaletteModel.colors.indexOf(m) * chipHeight;
      fillRect(
        image,
        0,
        y,
        width,
        y + chipHeight,
        getColor(m.color.red, m.color.green, m.color.blue),
      );
    });

    return image;
  }

  static Future<void> sharePalette(ColorPaletteModel colorPaletteModel) async {
    var image = paletteToImage(colorPaletteModel);
    await shareImage(image);
  }
}
