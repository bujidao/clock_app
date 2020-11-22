import 'package:clock_app/router/Router.dart';
import 'package:clock_app/services/touchEvent.dart';
import 'package:flutter/material.dart';

import 'ClockConfig.dart';

// 时钟weiget
import 'Flipclock/FlipClock.dart';
// import 'ParticleClock/ParticleClock.dart';

class Clock extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}
// ClockCustomizer((ClockModel model) => ParticleClock(model))
class _AlarmState extends State<Clock> {
  List<Widget> _alarmList = [
    FlipClock()
  ];
  int _currentAlarmIndex = 0;

  double _startX = 0.0;
  double _startY = 0.0;

/**
 * 切换时钟风格
 */
  _switchAlarmStyle(String moveDirection) {
    if (_alarmList.length == 1) return;
    if (moveDirection == 'rtl') {
      _currentAlarmIndex = _currentAlarmIndex >= _alarmList.length - 1 ? 0 : _currentAlarmIndex ++;
    } else {
      _currentAlarmIndex = _currentAlarmIndex <= 0 ? _alarmList.length - 1 : _currentAlarmIndex --;
    }
  }

/**
 * 显示配置页面
 */
  _showConfigPage() {
    MyNavigator(context, AlarmConfig(), 'ttb').push();
  }

  /**
   * 水平方向移动事件
   */
  _moveHorizontal(String moveDirection) {
    _switchAlarmStyle(moveDirection);
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
      child: _alarmList[_currentAlarmIndex]
    );
  }
}