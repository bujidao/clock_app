import 'dart:async';

import 'package:flutter/material.dart';
import './FlipNum.dart';

class Flip extends StatefulWidget {
  @override
  _FlipState createState() => _FlipState();
}

class _FlipState extends State<Flip> {

  int _hour = 0; // 时
  int _minute = 0; // 分

  double _startX = 0.0; // 开始滑动的x坐标

  @override
  void initState() {
    super.initState();

    // 获取当前时间
    _getCurrentTime();
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _getCurrentTime();
    });

    // 屏幕事件监听
    // _screenListen();
  }

/**
 * 获取并设置当前时间
 */
  void _getCurrentTime() {
    DateTime now = new DateTime.now();
    var hh = now.hour;
    var MM = now.minute;
    // var MM = now.second;
    setState(() {
      _hour = hh;
      _minute = MM;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MyThemeColor.colorAppBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              // 时
              child: FlipNumText(_hour, 23, true),
            ),
            Center(
              // 分
              child: FlipNumText(_minute, 59, false),
            ),
          ],
        ),
      );
  }
}

/**
 * 主题颜色
 */
class MyThemeColor {
  static const Color colorAppBackground = Color(0xff000000); // 背景颜色
  static const Color colorClockBackground = Color(0xff101010); // 文本背景色
  static const Color colorClockFont = Color(0xffb0b0b0); // 文本颜色
}
