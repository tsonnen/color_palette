import 'widgets/color_tile.dart';

class ColorPallete{
  List<ColorTile> colors;

  ColorPallete(int numColors){
    colors = new List<ColorTile>();
    for(int i = 0; i < numColors; ++i){
      colors.add(ColorTile());
    }
  }

  void generateColors(){
    for(ColorTile colorTile in colors){
      if(!colorTile.lock){
        colorTile.generateColor();
      }
    }
  }
}