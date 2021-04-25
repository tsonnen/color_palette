import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:image/image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../models/color_palette.dart';

class ShareHelper {
  static Future<void> shareImage(Image image) async {
    final list = encodePng(image) as Uint8List;

    if (kIsWeb) {
      await FileSaver.instance
          .saveFile('myPalette', list, 'png', mimeType: MimeType.PNG);
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);

    await Share.shareFiles(
      ['${tempDir.path}/image.jpg'],
      subject: 'share it!',
      text: 'share flutter',
    );
  }

  static Image paletteToImage(ColorPalette colorPaletteModel, Size size) {
    var width = size.width.toInt();
    var height = size.height.toInt();
    var chipHeight = (height / colorPaletteModel.colors.length).floor();
    var image = Image(width, height);

    colorPaletteModel.colors.forEach((m) {
      var y = colorPaletteModel.colors.indexOf(m) * chipHeight;
      fillRect(
        image,
        0,
        y,
        width,
        y + chipHeight,
        getColor(m.color.red, m.color.green, m.color.blue),
      );
      drawString(image, arial_48, 0, y + height ~/ 2, 'TESTSTSDTSTSDTRS');
    });

    return image;
  }

  static Future<void> sharePalette(
      ColorPalette colorPaletteModel, Size size) async {
    var image = paletteToImage(colorPaletteModel, size);
    await shareImage(image);
  }
}
