import 'package:color_palette/widgets/color_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_palette_model.dart';

enum PrefTypes { GenMethod, NumColors, ColorText }

class PreferenceManager {
  static final prefKeys = {
    PrefTypes.GenMethod: 'gen_method',
    PrefTypes.NumColors: 'num_colors',
    PrefTypes.ColorText: 'color_text'
  };
  static final prefix = 'pref_';
  static SharedPreferences prefs;

  static Future<void> getPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static GenMethod getGenMethod() {
    if (prefs != null) {
      var genMethod = prefs.getInt(prefix + prefKeys[PrefTypes.GenMethod]);
      return GenMethod.values[genMethod ?? 0];
    }
    return GenMethod.rand;
  }

  static ColorText getColorText() {
    if (prefs != null) {
      var colorText = prefs.getInt(prefix + prefKeys[PrefTypes.ColorText]);
      return ColorText.values[colorText ?? 0];
    }
    return ColorText.hex;
  }

  static int getNumColors() {
    if (prefs != null) {
      var numColors = prefs.getInt(prefix + prefKeys[PrefTypes.NumColors]);
      return numColors ?? 5;
    }
    return 5;
  }

  static setNumColors(int value) {
    if (prefs != null) {
      prefs.setInt(prefix + prefKeys[PrefTypes.NumColors], value);
    }
  }
}
