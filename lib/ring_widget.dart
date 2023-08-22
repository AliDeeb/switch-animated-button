import 'package:flutter/material.dart';

class RingWidget extends StatelessWidget {
  const RingWidget({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: RingPainter()),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    final outerRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
    final innerRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width / 2,
      height: size.height / 2,
    );
    final outer =
        RRect.fromRectAndRadius(outerRect, const Radius.circular(100));
    final inner =
        RRect.fromRectAndRadius(innerRect, const Radius.circular(100));

    double z = 0;
    for (double i = 0; i <= 0.8; i += 0.1) {
      z = (z - 0).abs() + i;
      Matrix4 transform = (Matrix4.identity()..translate(0.0, 0.0, z));
      canvas.transform(transform.storage);
      canvas.drawDRRect(outer, inner, paint);

      z = (z - 0).abs() + i;
      transform = (Matrix4.identity()..translate(0.0, 0.0, -z));
      canvas.transform(transform.storage);
      canvas.drawDRRect(outer, inner, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
