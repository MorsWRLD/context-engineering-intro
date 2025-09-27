import 'package:flutter/material.dart';
import 'dart:math';

class NeonTimerRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color color;

  const NeonTimerRing({required this.progress, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeonPainter(progress, color),
      size: const Size(200, 200),
    );
  }
}

class _NeonPainter extends CustomPainter {
  final double progress;
  final Color color;

  _NeonPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => true;
}
