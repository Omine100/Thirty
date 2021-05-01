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
      painter: HomeNavigationPainter(context: context),
    );
  }
}

class HomeNavigationPainter extends CustomPainter {
  HomeNavigationPainter({Key key, this.context});

  //VARIABLE REFERENCE: Needed to load HomeNavigationPainter
  final BuildContext context;

  //CLASS INITALIZATION
  Themes themes = new Themes();

  //MECHANICS: Paint
  //DESCRIPTIONS: Goes over all of the different math for the geometric shape to
  //          paint on the screen
  //OUTPUT: Geometric printed shape
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = themes.getColor(context, "homeNavigationBarColor")
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

  //MECHANICS: Should repaint
  //DESCRIPTION: Returns whether or not the paint section should be rebuilt
  //OUTPUT: Boolean as to whether or not it should repaint
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
