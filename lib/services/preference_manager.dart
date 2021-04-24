import 'package:pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_palette_model.dart';
import '../widgets/color_chip.dart';

enum Pref {
  GenMethod,
  NumColors,
  ColorText,
  ShareUseScreenSize,
  ShareHeight,
  ShareWidth,
  ShowShareOptions
}

class PrefManager {
  static final GenMethodKey = 'gen_method';
  static final NumColorsKey = 'num_colors';
  static final ColorTextKey = 'color_text';
  static final ShareUseScreenSizeKey = 'share_use_screen_size';
  static final ShareHeightKey = 'share_height';
  static final ShareWidthKey = 'share_width';
  static final ShowShareOptionsKey = 'show_share_options';

  static final prefix = 'pref_';
  static SharedPreferences? prefs;

  static GenMethod getGenMethod(BasePrefService service) {
    var genMethod = service.get<int>(GenMethodKey) ?? 0;
    return GenMethod.values[genMethod];
  }

  static ColorText getColorText(BasePrefService service) {
    var colorText = service.get<int>(ColorTextKey) ?? 0;
    return ColorText.values[colorText];
  }

  static int getNumColors(BasePrefService service) {
    var numColors = service.get<int>(NumColorsKey) ?? 5;
    return numColors;
  }

  static bool getUseScreenSize(BasePrefService service) {
    var useScreenSize = service.get<bool>(ShareUseScreenSizeKey) ?? true;
    return useScreenSize;
  }

  static int getShareHeight(BasePrefService service) {
    var shareHeight = service.get<String>(ShareHeightKey) ?? '2280';
    return int.tryParse(shareHeight) ?? 2280;
  }

  static int getShareWidth(BasePrefService service) {
    var shareWidth = service.get<String>(ShareWidthKey) ?? '1080';
    return int.tryParse(shareWidth) ?? 1080;
  }

  static bool getShowShareOptionsDialog(BasePrefService service) {
    var showShareOptions = service.get<bool>(ShowShareOptionsKey) ?? true;
    return showShareOptions;
  }

  static void setShareHeight(int shareHeight, BasePrefService service) {
    service.set<String>(ShareHeightKey, shareHeight.toString());
  }

  static void setShareWidth(int shareWidth, BasePrefService service) {
    service.set<String>(ShareWidthKey, shareWidth.toString());
  }

  static void setNumColors(int value, BasePrefService service) {
    service.set<int>(ShareHeightKey, value);
  }

  static dynamic get(String key, BasePrefService service) {
    var val = service.get(key);
    return val;
  }

  static void setString(String key, String val) {
    prefs!.setString(prefix + key, val);
  }
}
