
import 'package:flutter/foundation.dart';

Map<String, Function> refreshWidgets = {};

refreshWidget(String name) {
  // debugPrint('en refreshWidget $name');
  if (refreshWidgets.containsKey(name)) {
    try {
      final fun = refreshWidgets[name];
      // debugPrint('en refreshWidget $name, refreshing...');
      fun!();
    } catch (e) {
      if (kDebugMode) {
        // print('ERROR: refreshWidget: $name $e');
      }
    }
  }
}

addRefreshWidget(String name, Function function) {
  if (refreshWidgets.containsKey(name)) {
    refreshWidgets[name] = function;
  } else {
    refreshWidgets.putIfAbsent(name, () => function);
  }
}

removeRefreshWidget(String name) {
  if (refreshWidgets.containsKey(name)) {
    refreshWidgets.remove(name);
  }
}
