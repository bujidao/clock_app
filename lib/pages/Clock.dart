import 'package:clock_app/router/Router.dart';
import 'package:clock_app/services/touchEvent.dart';
import 'package:clock_app/utils/AnimateWidget.dart';
import 'package:clock_app/utils/Tools.dart';
// import 'package:clock_app/utils/flutter_clock/flutter_clock_helper/lib/customizer.dart';
// import 'package:clock_app/utils/flutter_clock/flutter_clock_helper/lib/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ClockConfig.dart';

// 时钟weiget
import 'FlipClock/FlipClock.dart';
import 'ParticleClock/particle_clock.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}
// ClockCustomizer((ClockModel model) => ParticleClock(model))
class _ClockState extends State<Clock> {
  List<Widget> _clockList = [
    FlipClock(),
    ParticleClock(),
    // ClockCustomizer((ClockModel model) => ParticleClock(model)),
  ];
  int _currentClockIndex = 0;

  double _startX = 0.0;
  double _startY = 0.0;

  String _moveDirection = 'ltr';

/**
 * 切换时钟风格
 */
  _switchClockStyle(String moveDirection) {
    if (_clockList.length == 1) return;
    int tmpIdx = 0;
    if (moveDirection == 'rtl') {
      tmpIdx = _currentClockIndex >= _clockList.length - 1 ? 0 : _currentClockIndex + 1;
    } else {
      tmpIdx = _currentClockIndex <= 0 ? _clockList.length - 1 : _currentClockIndex - 1;
    }
    setState(() {
      _currentClockIndex = tmpIdx;
    });
  }

/**
 * 显示配置页面
 */
  _showConfigPage() {
    MyNavigator(context, ClockConfig(), 'ttb').push();
  }

  /**
   * 水平方向移动事件
   */
  _moveHorizontal(String moveDirection) {
    _switchClockStyle(moveDirection);
    setState(() {
      _moveDirection = moveDirection;
    });
  }

  _moveVertical(String moveDirection) {
    if (moveDirection == 'ttb') {
      _showConfigPage();
    }
  }

  /**
   * 点击移动事件
   */
  _touchMoveEvent(event) {
    String moveDirection = MyTouch({'x': _startX, 'y': _startY}, event).getMoveDirection();
    if (moveDirection == 'ltr' || moveDirection == 'rtl') {
      _moveHorizontal(moveDirection);
    } else {
      _moveVertical(moveDirection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => {
        _startX = event.position.dx,
        _startY = event.position.dy
      },
      onPointerMove: (event) => {
        _touchMoveEvent(event)
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.linear,
        switchOutCurve: Curves.linear,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransitionX(
            child: child,
            direction: _moveDirection, //上入下出
            position: animation,
          );
        },
        child: _clockList[_currentClockIndex],
      ),
    );
  }
}