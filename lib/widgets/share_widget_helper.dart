import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import 'dialogs.dart';
import '../helpers/share_helper.dart';
import '../models/color_palette.dart';
import '../providers/color_text_provider.dart';
import '../services/preference_manager.dart';

class ShareWidgetHelper {
  static void share(
      {required BuildContext context,
      required ColorPalette colorPalette}) async {
    var service = PrefService.of(context);

    if (PrefManager.getShowShareOptionsDialog(service)) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShareOptionsDialog(colorPalette);
          });
    }
    await ShareHelper.sharePalette(
        colorPalette: colorPalette,
        colorTextProvider:
            Provider.of<ColorTextProvider>(context, listen: false),
        size: Size(PrefManager.getShareWidth(service).toDouble(),
            PrefManager.getShareHeight(service).toDouble()));
  }
}
