import 'dart:math';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CardWidget extends StatefulWidget {
  final Widget frontImage;
  final Widget backImage;
  final bool isClosed;

  const CardWidget({
    Key? key,
    required this.frontImage,
    required this.backImage,
    required this.isClosed,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    if (widget.isClosed) {
      _animationController.value = 0.0;
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClosed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationY(_animation.value * pi),
          alignment: Alignment.center,
          child: _animationController.value < 0.1
              ? widget.frontImage
              : Transform.flip(
                  flipX: true,
                  child: widget.backImage,
                ),
        );
      },
    );
  }
}
