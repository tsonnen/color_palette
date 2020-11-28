import 'dart:collection';

import 'package:flutter/cupertino.dart';

class ListenableList<T, E> extends MapMixin<T, E> with ChangeNotifier {
  final Map<T,E> m = {};

  @override
  E operator [](Object key) {
      return m[key];
    }
  
    @override
    void operator []=(T key, E value) {
      m[key] = value;
      notifyListeners();
    }
  
    @override
    void clear() {
      m.clear();
      notifyListeners();
    }
  
    @override
    Iterable<T> get keys => m.keys;
  
    @override
    E remove(Object key) {
       var val = m.remove(key);
     notifyListeners();
     return val; 
  }

}
