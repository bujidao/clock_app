import 'package:flutter/cupertino.dart';

import 'dart:ui';

class MyTools {
  positionToTween(String position) {
    Map<String, Offset> positionTweenMap = {
      'rtl': Offset(1.0, 0.0),
      'ltr': Offset(-1.0, 0.0),
      'ttb': Offset(0.0, -1.0),
      'btt': Offset(0.0, 1.0),
      'default': Offset(0.0, 0.0),
    };
    Offset tmpTween;
    tmpTween = positionTweenMap.containsKey(position) ? positionTweenMap[position] : positionTweenMap['default'];
    return tmpTween;
  }
}