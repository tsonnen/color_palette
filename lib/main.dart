import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

import 'models/color_palette_model.dart';
import 'models/listenable_list.dart';
import 'services/preference_manager.dart';
import 'screens/color_palette_screeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init(prefix: PreferenceManager.prefix);

  await PreferenceManager.getPreferences();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ColorPaletteModel>(
      create: (context) => ColorPaletteModel(
          PreferenceManager.getNumColors(), PreferenceManager.getGenMethod()),
    ),
    ChangeNotifierProvider<ListenableList<String, ColorPaletteModel>>(
      create: (context) => ListenableList<String, ColorPaletteModel>(),
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
