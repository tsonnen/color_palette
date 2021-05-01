import 'dart:ui';

import 'package:color_palette/services/generation_methods.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import 'models/color_palette.dart';
import 'screens/color_palette_screen.dart';
import 'services/color_palette_box.dart';
import 'services/preference_manager.dart';
import 'widgets/color_chip.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var service =
      await PrefServiceShared.init(prefix: PrefManager.prefix, defaults: {
    PrefManager.GenMethodKey: GenMethodEnum.median.index,
    PrefManager.NumColorsKey: 5,
    PrefManager.ColorTextKey: ColorText.hex.index,
    PrefManager.ShareUseScreenSizeKey: true,
    PrefManager.ShowShareOptionsKey: true
  });

  if (PrefManager.getUseScreenSize(service)) {
    PrefManager.setShareHeight(window.physicalSize.height.toInt(), service);
    PrefManager.setShareWidth(window.physicalSize.width.toInt(), service);
  }

  await Hive.initFlutter();
  var colorPalettesBox = ColorPaletteBox();
  await colorPalettesBox.init();

  runApp(PrefService(
      service: service,
      child: MultiProvider(providers: [
        ChangeNotifierProvider<ColorPalette>(
          create: (context) => ColorPalette.generated(
              length: service.get(PrefManager.NumColorsKey),
              generationMethod:
                  GenerationMethod.mapEnum(PrefManager.getGenMethod(service))),
        ),
        ChangeNotifierProvider<ColorPaletteBox>(
          create: (context) => colorPalettesBox,
        ),
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ColorPaletteScreen(),
    );
  }
}
