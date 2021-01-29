import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ShareHelper{
  static shareImage(Image image) async {
      final ByteData bytes = image.
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(list);

     await Share.shareFiles(
            ['${tempDir.path}/image.jpg'],
            subject: "share it!",
            text: "share flutter",
     );

  }
}