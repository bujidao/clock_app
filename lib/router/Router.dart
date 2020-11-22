/*
 * @Author       : Alex Ceng
 * @Date         : 2020-11-22 11:40:27
 * @LastEditors  : Alex Ceng
 * @LastEditTime : 2020-11-22 13:04:59
 * @Group        : 
 * @Description  : 封装自定义页面切换效果
 */
import 'package:flutter/cupertino.dart';

class MyNavigator {
  var context; // 上下文
  Widget TargetWidget; // 目标页面
  String targetEnterPosition; // 目标页面进入方式
  MyNavigator(this.context, this.TargetWidget, this.targetEnterPosition);

  /**
   * 页面进入方式map
   */
  Map<String, Offset> enterPositionMap = {
    'rtl': Offset(1.0, 0.0),
    'ltr': Offset(-1.0, 0.0),
    'ttb': Offset(0.0, -1.0),
    'btt': Offset(0.0, 1.0),
    'default': Offset(0.0, 0.0),
  };

  // 页面切换效果
  Route _createRoute() {
    var begin = enterPositionMap.containsKey(targetEnterPosition) ? enterPositionMap[targetEnterPosition] : enterPositionMap['default'];
    var end = Offset.zero;
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TargetWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  push () {
    Navigator.of(context).push(_createRoute());
  }
}
