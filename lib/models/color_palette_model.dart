import 'package:color_palette/models/swatch_model.dart';

enum GenMethod {
  rand,
  pastel,
  median,
  prevMerge,
}

class ColorPaletteModel {
  static final generationMethodMap = {
    GenMethod.rand: "Random",
    GenMethod.pastel: "Pastel",
    GenMethod.median: "Median Color",
    GenMethod.prevMerge: "Previous Merge"
  };
  List<SwatchModel> colors  = List<SwatchModel>();
  final genMethod;

  ColorPaletteModel(length, {this.genMethod: GenMethod.rand}) {
    

    for(var i =0; i < length; ++i){
      colors.add(new SwatchModel());
    }

    generateColors();
  }

  void generateColors() {
    colors.where((element) {
      return !(element?.lock ?? false);
    }).forEach((element) {
      element?.getRandomColor();
    });
  }
}
