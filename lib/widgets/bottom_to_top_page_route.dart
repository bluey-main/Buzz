import 'package:flutter/material.dart';

class BottomTopPageRoute<T> extends MaterialPageRoute<T> {
  BottomTopPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 2.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}