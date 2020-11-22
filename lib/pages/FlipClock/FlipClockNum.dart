import 'dart:math';

import 'package:clock_app/pages/FlipClock/FlipClock.dart';
import 'package:flutter/material.dart';

class FlipClockNumText extends StatefulWidget {
  // 当前传入的数字
  final int num;
  // 当前数字的最大值
  final int maxNum;
  final bool showCornerMark;

  FlipClockNumText(this.num, this.maxNum, this.showCornerMark);

  @override
  _FlipClockNumTextState createState() => _FlipClockNumTextState();
}

class _FlipClockNumTextState extends State<FlipClockNumText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool _isReversePhase = false;

  double _zeroAngle = 0.0001;

  int _stateNum = 0;
  bool _showCornerMark = false;

  @override
  void initState() {
    super.initState();
    _stateNum = widget.num;
    _showCornerMark = widget.showCornerMark;

    _initAnimationController();

    ///四分之一的圆弧长度
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);
  }

/**
 * 初始化动画控制器
 */
  _initAnimationController() {
  ///动画控制器，正向执行一次后再反向执行一次每次时间为450ms。
    _controller = new AnimationController(duration: Duration(milliseconds: 200), vsync: this)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ///正向动画执行结束后，反向动画执行标志位设置true 进行反向动画执行
        _controller.reverse();
        _isReversePhase = true;
      }
      if (status == AnimationStatus.dismissed) {
        ///反向动画执行结束后，反向动画执行标志位false 将当前数值加一更改为动画后的值
        _isReversePhase = false;
        _calNum();
      }
    })
    ..addListener(() {
      setState(() {});
    });
  }

/**
 * 页面文本框的位置布局
 */
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(_addZero(_nextNum()), Alignment.topCenter),
              ///动画正向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                alignment: Alignment.bottomCenter,
                child: ClipRectText(_addZero(_stateNum), Alignment.topCenter)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: <Widget>[
              ClipRectText(_addZero(_stateNum), Alignment.bottomCenter),
              ///动画反向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? -_animation.value : pi / 2),
                alignment: Alignment.topCenter,
                child: ClipRectText(_addZero(_nextNum()), Alignment.bottomCenter)),
              _showCornerMark?ClipMoonText(_stateNum < 12 ? 'AM' : 'PM'):Text('')
            ],
          )
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(FlipClockNumText oldWidget) {
    if (this.widget.num != oldWidget.num) {
      _controller.forward();
      _stateNum = oldWidget.num;
    }
    super.didUpdateWidget(oldWidget);
  }

  _nextNum() {
    if (_stateNum == widget.maxNum) {
      return 0;
    } else {
      return _stateNum + 1;
    }
  }

  _calNum() {
    if (_stateNum == widget.maxNum) {
      _stateNum = 0;
    } else {
      _stateNum += 1;
    }
  }

/**
 * 数字小于10， 添加一个零
 */
  _addZero(int num) {
    String tmpNum = num.toString();
    if(tmpNum.length < 2) {
      tmpNum = '0' + tmpNum;
    }
    return tmpNum;
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }
  }
}

/**
 * 翻页里面填充内容
 */
class ClipRectText extends StatelessWidget {
  final String _value;
  final Alignment _alignment;

  ClipRectText(this._value, this._alignment);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width / 2.5;
    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
            color: MyThemeColor.colorClockBackground,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Text(
            "$_value",
            style: TextStyle(
              // fontFamily: "SanFrancisco",
              // fontFamily: "LockClock",
              fontFamily: "SanFrancisco",
              fontSize: width/1.2,
              color: MyThemeColor.colorClockFont,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

/**
 * 上午下午角标
 */
class ClipMoonText extends StatelessWidget {
  final String _value;

  ClipMoonText(this._value);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width / 3 + 10;
    return Positioned( // red box
      child:  Container(
        child: Text(
          "$_value",
          style: TextStyle(
            fontSize: width / 10,
            color: MyThemeColor.colorClockFont,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      bottom: 5,
      left: 20,
    );
  }
}
