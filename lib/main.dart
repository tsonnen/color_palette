import 'color_palette_model.dart';
import 'package:flutter/material.dart';

import 'widgets/color_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorPallete colorPallete = new ColorPallete(5);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          for (ColorTile colorTile in colorPallete.colors)
            Expanded(child: colorSwatch(colorTile)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            colorPallete.generateColors();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget colorSwatch(ColorTile colorTile) {
    Color textColor =
        colorTile.color.computeLuminance() < .5 ? Colors.white : Colors.black;
    return DecoratedBox(
        decoration: BoxDecoration(
          color: colorTile.color,
        ),
        child: new Row(children: <Widget>[
          IconButton(
            icon: Icon(colorTile.lock ? Icons.lock : Icons.lock_open),
            color: textColor,
            onPressed: () {
              setState(() {
                colorTile.lock = !colorTile.lock;
              });
            },
          ),
          new Container(
            child: Text(
              colorTile.color.toString(),
              style: TextStyle(color: textColor),
              textAlign: TextAlign.center,
            ),
          )
        ]));
  }
}
