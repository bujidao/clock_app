/*
 * @Author       : Alex Ceng
 * @Date         : 2020-11-22 13:50:01
 * @LastEditors  : Alex Ceng
 * @LastEditTime : 2020-11-22 13:50:52
 * @Group        : 
 * @Description  : 屏幕移动方向
 */

class MyTouch {
  var event;
  Map<String, double> startAxios;
  MyTouch(this.startAxios, this.event);

  getMoveDirection() {
    String moveDirection = '';
    double distanceX = event.position.dx - startAxios['x'];
    double distanceY = event.position.dy - startAxios['y'];
    if (distanceX.abs() > 100 || distanceY.abs() > 100){
      if (distanceX.abs() > distanceY.abs() ) {
        // 水平滑动
        moveDirection = distanceX > 0 ? 'ltr' : 'rtl';
      } else {
        // 垂直滑动
        moveDirection = distanceY > 0 ? 'ttb' : 'btt';
      }
    }
    return moveDirection;
  }
}
