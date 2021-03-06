import 'package:color_palette/widgets/color_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_palette_model.dart';

enum PrefTypes {
  GenMethod,
  NumColors,
  ColorText,
  ShareUseScreenSize,
  ShareHeight,
  ShareWidth,
  ShowShareOptionsDialog
}

class PreferenceManager {
  static final prefKeys = {
    PrefTypes.GenMethod: 'gen_method',
    PrefTypes.NumColors: 'num_colors',
    PrefTypes.ColorText: 'color_text',
    PrefTypes.ShareUseScreenSize: 'share_use_screen_size',
    PrefTypes.ShareHeight: 'share_height',
    PrefTypes.ShareWidth: 'share_width',
    PrefTypes.ShowShareOptionsDialog: 'show_share_options'
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

  static bool getUseScreenSize() {
    if (prefs != null) {
      var useScreenSize =
          prefs.getBool(prefix + prefKeys[PrefTypes.ShareUseScreenSize]);
      return useScreenSize ?? true;
    }
    return true;
  }

  static int getShareHeight() {
    if (prefs != null) {
      var shareHeight =
          prefs.getString(prefix + prefKeys[PrefTypes.ShareHeight]);
      return int.tryParse(shareHeight) ?? 2280;
    }
    return 2280;
  }

  static int getShareWidth() {
    if (prefs != null) {
      var shareWidth = prefs.getString(prefix + prefKeys[PrefTypes.ShareWidth]);
      return int.tryParse(shareWidth) ?? 1080;
    }
    return 1080;
  }

  static void setShareHeight(int shareHeight) {
    if (prefs != null) {
      prefs.setString(
          prefix + prefKeys[PrefTypes.ShareHeight], shareHeight.toString());
    } else {
      throw ('Prefs not initialized!');
    }
  }

  static void setShareWidth(int shareWidth) {
    if (prefs != null) {
      prefs.setString(
          prefix + prefKeys[PrefTypes.ShareWidth], shareWidth.toString());
    } else {
      throw ('Prefs not initialized!');
    }
  }

  static void setNumColors(int value) {
    if (prefs != null) {
      prefs.setInt(prefix + prefKeys[PrefTypes.NumColors], value);
    } else {
      throw ('Prefs not initialized!');
    }
  }

  static dynamic get(String key) {
    var val = prefs.get(prefix + key);
    return val;
  }

  static void setString(String key, String val) {
    prefs.setString(prefix + key, val);
  }

  static bool getShowShareOptionsDialog() {
    if (prefs != null) {
      var showShareOptions =
          prefs.getBool(prefix + prefKeys[PrefTypes.ShowShareOptionsDialog]);
      return showShareOptions ?? false;
    }
    return false;
  }
}
