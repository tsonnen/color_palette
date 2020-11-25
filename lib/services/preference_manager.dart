import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_palette_model.dart';

class PreferenceManger {
  static SharedPreferences prefs;

  static Future<void> getPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static GenMethod getGenMethod() {
    if (prefs != null) {
      var genMethod = prefs.getInt('pref_gen_method');
      return GenMethod.values[genMethod ?? 0];
    }
    return GenMethod.rand;
  }
}
