import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';
import 'package:path_provider/path_provider.dart';

import 'models/color_palette_model.dart';
import 'models/listenable_map.dart';
import 'services/preference_manager.dart';
import 'screens/color_palette_screeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDir = await getApplicationDocumentsDirectory();
  await PrefService.init(prefix: PreferenceManager.prefix);

  await PreferenceManager.getPreferences();
  if (PreferenceManager.getUseScreenSize()) {
    PreferenceManager.setShareHeight(window.physicalSize.height.toInt());
    PreferenceManager.setShareWidth(window.physicalSize.width.toInt());
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ColorPaletteModel>(
      create: (context) => ColorPaletteModel(
          PreferenceManager.getNumColors(), PreferenceManager.getGenMethod()),
    ),
    ChangeNotifierProvider<ListenableMap>(
      create: (context) => ListenableMap.fromFile('${appDir.path}/colors.json'),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ColorPaletteScreen(),
    );
  }
}
