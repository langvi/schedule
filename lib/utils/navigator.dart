import 'package:flutter/material.dart';

void navToScreenWithTransition(
    {required BuildContext context,
    required Widget toPage,
    Function? callback}) async {
  await Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => toPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var curve = Curves.ease;
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  ));
  if (callback != null) callback();
}
