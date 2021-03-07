// @dart=2.9
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

///Custom Animation wrapper widget for fade animations
///Accepts 3 values delay, y axis intial position and a child
class FadeAnimation extends StatelessWidget {

  final double delay; //animation delay
  final Widget child; //child widget
  final double posY; //animation initial position on y axis

  FadeAnimation(this.delay, this.posY, this.child);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final tween = MultiTrackTween([
      // ignore: deprecated_member_use
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      // ignore: deprecated_member_use
      Track("translateY")
          .add(Duration(milliseconds: 500), Tween(begin: posY, end: 0.0),
              //-50.0, end: 0.0),
              curve: Curves.easeOut)
    ]);

    // ignore: deprecated_member_use
    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
