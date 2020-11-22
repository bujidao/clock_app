import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/Clock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 全屏显示app
  SystemChrome.setEnabledSystemUIOverlays ([]);
  // 强制横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock',
      home: Clock(),
    );
  }
}
