import 'package:color_palette/screens/color_palette_screeen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorPaletteScreen(),
    );
  }
}
