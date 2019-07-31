import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PushAnimation extends StatefulWidget {
  @override
  _PushAnimationState createState() => _PushAnimationState();
}

class _PushAnimationState extends State<PushAnimation> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(vsync: this, duration: new Duration(seconds: 3));
    _animation = _controller.drive(ColorTween(begin: Colors.red, end: Colors.blue))
    ..addListener(() {
      setState(() {
        
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _controller,
    builder: (context, child) {
      return Container(
      decoration: BoxDecoration(
        color: _animation.value
      ),
    );
    });
    
  }
}