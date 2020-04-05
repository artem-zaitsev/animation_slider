import 'package:animation_slider/card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AnimationSliderDemo extends StatefulWidget {
  @override
  _AnimationSliderDemoState createState() => _AnimationSliderDemoState();
}

class _AnimationSliderDemoState extends State<AnimationSliderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  static const idxs = const [0, 1, 2, 3];
  static const _opacity = [0, 0.075, 0.075 * 2, 0.075 * 3];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 650,
            child: GestureDetector(
              // dragStartBehavior: DragStartBehavior.start,
              // onPanStart: _onPanStart,
              // onPanUpdate: _onPanUpdate,
              // onPanEnd: _onPanEnd,
              // onTap: () {
              //   if (_bundles.length == 1) return;
              //   _move(1, false);
              // },
              child: Stack(
                children: [
                  for (var b in idxs) _buildStackChild(b),
                ].reversed.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackChild(int idx) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (c, w) => _buildAnimation(c, w, idx),
      child: SkillCard(
        key: ValueKey(idx),
      ),
    );
  }

  Widget _buildAnimation(BuildContext ctx, Widget w, int idx) {
    var isFirstBundle = idx == 0;
    var scale = 1 - idx * 0.01;
    var dy = 1 + 0.005 * idx;

    return Transform.scale(
      alignment: Alignment.bottomCenter,
      scale: scale,
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Opacity(
          opacity: isFirstBundle ? 1 : 1 - _opacity[idx],
          child: w,
        ),
      ),
    );
  }
}
