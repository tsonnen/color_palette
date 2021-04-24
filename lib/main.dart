import 'dart:ui';

import 'package:color_palette/widgets/color_chip.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:path_provider/path_provider.dart';

import 'models/color_palette_model.dart';
import 'models/listenable_map.dart';
import 'services/preference_manager.dart';
import 'screens/color_palette_screeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDir = await getApplicationDocumentsDirectory();
  var service =
      await PrefServiceShared.init(prefix: PrefManager.prefix, defaults: {
    'gen_method': GenMethod.median.index,
    'num_colors': 5,
    'color_text': ColorText.hex.index,
    'share_use_screen_size': true,
    'show_share_options': true
  });

  if (PrefManager.getUseScreenSize(service)) {
    PrefManager.setShareHeight(window.physicalSize.height.toInt(), service);
    PrefManager.setShareWidth(window.physicalSize.width.toInt(), service);
  }

  runApp(PrefService(
      service: service,
      child: MultiProvider(providers: [
        ChangeNotifierProvider<ColorPaletteModel>(
          create: (context) => ColorPaletteModel(
              service.get(PrefManager.NumColorsKey),
              GenMethod.values[service.get(PrefManager.GenMethodKey)]),
        ),
        ChangeNotifierProvider<ListenableMap>(
          create: (context) =>
              ListenableMap.fromFile('${appDir.path}/colors.json'),
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
