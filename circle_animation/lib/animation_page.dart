import 'dart:core';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  var _positions = <TolyCircle>[];
  var _lines = <List<TolyCircle>>[];

  @override
  Widget build(BuildContext context) {
    //按下时表示新添加一条线,并记录上一点位置
    void _panDown(DragDownDetails details) {
      var x = details.globalPosition.dx;
      var y = details.globalPosition.dy;
      print('pan down ${_positions.toString()}');
      _lines.add(_positions);
      //panDown 也记录一个点 
      _positions.add(TolyCircle(Colors.blue, Offset(x, y), radius: 4.0));
    }

    ///移动中，将点添加到点集中
    void _panUpdate(DragUpdateDetails details) {
      print('pan update');
      var x = details.globalPosition.dx;
      var y = details.globalPosition.dy;
      var curPos = Offset(x, y);
      var tolyCirle = TolyCircle(Colors.blue, curPos, radius: 4.0);
      _positions.add(tolyCirle);
      setState(() {});
    }

    /// 抬起后，将旧线拷贝到线集中
    void _panEnd(DragEndDetails details) {
      var oldLine = <TolyCircle>[];
      for (var i = 0; i < _positions.length; i++) {
        oldLine.add(_positions[i]);
      }
      _lines.add(oldLine);
      _positions.clear();
    }

    return GestureDetector(
      child: Scaffold(
        body: CustomPaint(
          painter: Paper(lines: _lines),
        ),
      ),
      onPanStart: (DragStartDetails details) {
        print('pan start');
        //从start开始记录点更流畅一些
        var x = details.globalPosition.dx;
        var y = details.globalPosition.dy;
        _positions.add(TolyCircle(Colors.blue, Offset(x, y), radius: 4.0));
      },
      onPanDown: (DragDownDetails details) {
        _panDown(details);
      },
      onPanUpdate: _panUpdate,
      onPanEnd: _panEnd,
      onDoubleTap: () {
        // _lines.clear();
        // setState(() {});
      },
    );
  }
}

class TolyDrawable {
  Offset pos;
  Color color;
  TolyDrawable(this.pos, this.color);
}

class TolyCircle extends TolyDrawable {
  double radius;
  TolyCircle(Color color, Offset pos, {this.radius = 4.0}) : super(pos, color);
}

class Paper extends CustomPainter {
  Paper({
    @required this.lines,
    this.positions,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  Paint _paint;
  final List<List<TolyCircle>> lines;
  final List<TolyCircle> positions;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void drawLine(Canvas canvas, List<TolyCircle> positions) {
    //注意这里是positions.length - 1
    for (var i = 0; i < positions.length - 1; i++) {
      if (positions[i] != null && positions[i + 1] != null) {
        canvas.drawLine(positions[i].pos, positions[i + 1].pos,
            _paint..strokeWidth = positions[i].radius);
        _paint..color = positions[i].color ?? Colors.red;
      }
    }
  }
}
