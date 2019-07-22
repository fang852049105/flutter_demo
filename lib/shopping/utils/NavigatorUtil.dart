import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/routers/application.dart';
import 'package:flutter_demo/shopping/routers/routes.dart';

class NavigatorUtil {
  /// 返回
  static void goBack(BuildContext context) {
    /// 其实这边调用的是 Navigator.pop(context);
    Application.router.pop(context);
  }

  /// 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  /// 跳转到主页面
  static void goHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.home, replace: true);
  }


  /// 跳转到 转场动画 页面 ， 这边只展示 inFromRight ，剩下的自己去尝试下，
  /// 框架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom
  static Future goTransitionFromRightPage(BuildContext context, String router, String params) {
    ///路由跳转navigateTo()逻辑：
    /// 1、根据path从RouteTree中找到对应的AppRouteMatch
    /// 2、根据AppRouteMatch构建RouteMatch
    //、  3、使用RouteMatch中的route发起Navigator跳转。
    return Application.router.navigateTo(
        context, router + '?' + params,
        /// 指定了 转场动画
        transition: TransitionType.inFromRight);
  }

  /// 自定义 转场动画
  static Future goTransitionCustomPage(BuildContext context,String router, String title) {
    var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return new ScaleTransition(
        scale: animation,
        child: new RotationTransition(
          turns: animation,
          child: child,
        ),
      );
    };
    return Application.router.navigateTo(
        context, router + "?title=$title",
        transition: TransitionType.custom, /// 指定是自定义动画
        transitionBuilder: transition, /// 自定义的动画
        transitionDuration: const Duration(milliseconds: 600)); /// 时间
  }

  /// 使用 IOS 的 Cupertino 的转场动画，这个是修改了源码的 转场动画
  /// Fluro本身不带，但是 Flutter自带
  static Future gotransitionCupertinoPage(BuildContext context,String router, String title) {
    return Application.router.navigateTo(
        context, router + "?title=$title",
        transition: TransitionType.cupertino);
  }
}
