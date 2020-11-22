import 'dart:math';

import 'package:clock_app/router/Router.dart';
import 'package:clock_app/services/touchEvent.dart';
import 'package:flutter/material.dart';
import 'Clock.dart';
import 'FlipClock/Flip.dart';
import 'FlipClock/FlipNum.dart';

class AlarmConfig extends StatefulWidget {

  AlarmConfig();

  @override
  _AlarmConfigState createState() => _AlarmConfigState();
}

class _AlarmConfigState extends State<AlarmConfig>{
  double _startX = 0.0;
  double _startY = 0.0;

  @override
  void initState() {
    super.initState();
  }
/**
 * 回到首页
 */
  _goHome() async {
    MyNavigator(context, Clock(), 'btt').push();
  }

  /**
   * 滑动事件
   */
  _touchMoveEvent(event) {
    String moveDirection = MyTouch({'x': _startX, 'y': _startY}, event).getMoveDirection();
    if (moveDirection == 'btt') {
      _goHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Listener(
      onPointerDown: (event) => {
        _startX = event.position.dx,
        _startY = event.position.dy
      },
      onPointerMove: (event) => {
        _touchMoveEvent(event)
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyThemeColor.colorAppBackground,
          // image: DecorationImage(
          //   image: NetworkImage('https://clubimg.club.vmall.com/data/attachment/forum/201905/17/082652qm7mayijp9eua6d5.jpg'),
          //   fit: BoxFit.cover
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              // 时
              child: FlipNumText(00, 23, false),
            ),
            Center(
              // 分
              child: FlipNumText(00, 59, false),
            ),
          ],
        ),
      )
    );
  }
}

