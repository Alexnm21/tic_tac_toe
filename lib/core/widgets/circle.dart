import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/theme/app_colors.dart';

class Circle extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;
  const Circle({super.key, this.size = 24,  this.strokeWidth = 8, this.color = AppColors.secondary});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(color: color, strokeWidth: strokeWidth),
      size: Size(size, size),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  CirclePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}