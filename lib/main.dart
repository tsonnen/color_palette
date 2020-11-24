import 'package:color_palette/models/color_palette_model.dart';
import 'package:color_palette/widgets/color_chip.dart';
import 'package:flutter/material.dart';

import 'widgets/color_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ColorPalette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorPaletteModel colorPallete = new ColorPaletteModel(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: colorPallete.colors
            .map((e) => Expanded(child: ColorChip(e)))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            colorPallete.generateColors();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
