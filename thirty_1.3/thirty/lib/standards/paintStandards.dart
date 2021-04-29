import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class Paints {
  //CLASS INITIALIZATION
  Themes themes = new Themes();

  //USER INTERFACE: Home navigation bar paint
  //OUTPUT: Custom paint for the home.dart navigation bar
  CustomPaint homeNavigationBarPaint(BuildContext context) {
    return CustomPaint(
      size: Size(
        themes.getDimension(context, false, "homeNavigationBarDimension"),
        themes.getDimension(context, true, "homeNavigationBarDimension"),
      ),
      painter: HomeNavigationPainter(),
    );
  }
}

class HomeNavigationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
