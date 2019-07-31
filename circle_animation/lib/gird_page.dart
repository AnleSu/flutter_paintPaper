import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class GirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(
          painter: GirdPainter(10),
          size: Size(300, 300),
        ),
      ),
    );
  }
}

class GirdPainter extends CustomPainter {
  int count;
  GirdPainter(this.count);
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width / count;
    double h = size.height / count;
    Paint _bgPaint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    //画矩形
    canvas.drawRect(Offset.zero & size, _bgPaint);

    var _circlePaint = new Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;
    //画圆
    // canvas.drawCircle(Offset(100, 100), 50, _circlePaint);

    //画圆弧
    var rect = Rect.fromCircle(center: Offset(100.0, 100.0), radius: 50.0);
    canvas.drawArc(rect, -pi/2, pi/2, false, _circlePaint);


      //画点
    // List<Offset> points = [
    //   Offset(0, 0),
    //   Offset(30, 50),
    //   Offset(20, 80),
    //   Offset(100, 40),
    //   Offset(150, 90),
    //   Offset(60, 110),
    //   Offset(260, 160),
    // ];

    // var _pointPaint = Paint()
    //   ..color = Color(0xFFFf0000)
    //   ..strokeWidth = 5;
  
    // canvas.drawPoints(PointMode.polygon, points, _pointPaint);

    //画网格
    // Paint _paint = new Paint()
    // ..color = Colors.yellow[100]
    // ..style = PaintingStyle.stroke
    // ..strokeWidth = 1.0;
    // // TODO: implement paint
    // for (var i = 0; i <= count; i++) {
    //   double dx = w * i;
    //   double dy = h * i;
    //   //画横线
    //   canvas.drawLine(Offset(0, dy), Offset(size.width, dy), _paint);

    //   canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), _paint);
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
