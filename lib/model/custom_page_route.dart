// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

enum CustomOffset {
  fromTopRightCorner,
  fromTopLeftCorner,
  fromBottomRightCorner,
  fromBottomLeftCorner,
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final dynamic direction;
  final Duration duration;
  final dynamic choice;

  CustomPageRoute({
    required this.child,
    this.direction,
    required this.duration,
    this.choice,
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset? getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
    switch (choice) {
      case CustomOffset.fromTopRightCorner:
        return const Offset(1, -1);
      case CustomOffset.fromTopLeftCorner:
        return const Offset(-1, -1);
      case CustomOffset.fromBottomRightCorner:
        return const Offset(1, 1);
      case CustomOffset.fromBottomLeftCorner:
        return const Offset(-1, 1);
    }
  }
}
