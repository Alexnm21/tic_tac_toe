import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/theme/app_colors.dart';

class Cross extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;
  const Cross({super.key, this.size = 24,this.strokeWidth = 8, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CrossPainter(color: color, strokeWidth: strokeWidth),
      size: Size(size, size),
    );
  }
}

class CrossPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  CrossPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),

      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}