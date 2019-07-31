import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'animation_page.dart';
import 'gird_page.dart';
import 'paintpaper_page.dart';
import 'push_animation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Experiments',
      theme: new ThemeData(),
      home: new Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '圆圈转圈动画',
          style: TextStyle(color: Colors.white, letterSpacing: 1.0),
        ),
        backgroundColor: Color(0xff2979ff),
        centerTitle: true,
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  double percentage = 0.0;
  AnimationController percentageAnimationController;
  bool isClick = false;

  @override
  void initState() {
    super.initState();
    percentageAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000))
      ..repeat()
      ..addListener(() {
        percentage = percentageAnimationController.value * pi * 2;
        // setState(() {
          
        // });
      });
  }

  @override
  void dispose() {
    percentageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        height: 200.0,
        width: 200.0,
        child: AnimatedBuilder(animation: percentageAnimationController, builder: (context, child) {
          return new CustomPaint(
            
          foregroundPainter: new MyPainter(
              lineColor: Colors.lightBlueAccent,
              completeColor: Colors.blueAccent,
              startPercent: percentage,
              isComplete: isClick,
              width: 8.0),
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(
                color: Colors.green,
                splashColor: Colors.transparent,
                shape: new CircleBorder(),
                child: new Text("Click"),
                onPressed: () {
                  isClick = true;

                    percentageAnimationController.forward(from: 0.0);
                  // setState(() {
                    
                  // });
                  // Navigator.push(context, CupertinoPageRoute(
                  //   builder: (context) => new PushAnimation())
                  // );
                }),
          ),
        );
        })
        
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double startPercent;
  bool isComplete = false;
  double width;

  MyPainter(
      {this.lineColor,
      this.completeColor,
      this.startPercent,
      this.width,
      this.isComplete : false});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    double radius = min(size.width / 2, size.height / 2); //  半径
    canvas.drawCircle(
//  画圆方法
        center,
        radius,
        line);

    double arcAngle = isComplete == true ? startPercent : 2 * pi / 10;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        isComplete == true ? 2 * pi  : startPercent, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return startPercent != oldDelegate.startPercent;
  }
}
