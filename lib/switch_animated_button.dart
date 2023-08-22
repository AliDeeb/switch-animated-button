import 'dart:math';

import 'package:flutter/material.dart';
import 'package:switch_animated_button/ring_widget.dart';

class SwitchAnimatedButton extends StatefulWidget {
  const SwitchAnimatedButton({
    super.key,
    required this.value,
    this.size = 70,
    this.activeColor = const Color.fromARGB(255, 7, 205, 13),
    this.inactiveColor = const Color.fromARGB(255, 227, 19, 12),
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.elasticOut,
    this.onTap,
  });

  final bool value;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;

  @override
  State<SwitchAnimatedButton> createState() => _SwitchAnimatedButtonState();
}

class _SwitchAnimatedButtonState extends State<SwitchAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotateYAnimation;
  late bool value;

  @override
  void initState() {
    super.initState();

    value = widget.value;
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    rotateYAnimation = Tween<double>(
      begin: value ? -(85 * pi / 180) : 0,
      end: 0,
    ).animate(controller);
  }

  @override
  void didUpdateWidget(covariant SwitchAnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != value) {
      rotateYAnimation = Tween<double>(
        begin: value ? -(100 * pi / 180) : 0,
        end: value ? -pi : -(85 * pi / 180),
      ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

      controller.reset();
      controller.forward();
      setState(() => value = widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: value ? widget.activeColor : widget.inactiveColor,
        shape: BoxShape.circle,
      ),
      child: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white54,
          customBorder: const CircleBorder(),
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: rotateYAnimation,
            builder: (context, child) {
              return Container(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(rotateYAnimation.value),
                transformAlignment: Alignment.center,
                child: RingWidget(size: widget.size * .6),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
