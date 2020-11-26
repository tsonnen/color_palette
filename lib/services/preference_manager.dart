import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_palette_model.dart';

enum PrefTypes{
  GenMethod
}

class PreferenceManager {
  static final prefKeys = {PrefTypes.GenMethod: "gen_method'"};
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
}
