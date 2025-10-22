import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/colors.dart';
import '../../models/session.dart';

class CircularTimer extends StatelessWidget {
  final Duration elapsed;
  final TimerMode mode;
  final bool isRunning;

  const CircularTimer({
    super.key,
    required this.elapsed,
    required this.mode,
    this.isRunning = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = mode == TimerMode.chill 
        ? CyberpunkColors.chillMode 
        : CyberpunkColors.grindMode;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Animated neon ring
        CustomPaint(
          painter: NeonTimerPainter(
            progress: (elapsed.inSeconds % 60) / 60.0,
            color: color,
            isRunning: isRunning,
          ),
          size: const Size(280, 280),
        ),
        // Timer text
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formatDuration(elapsed),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: color,
                shadows: CyberpunkColors.neonGlow(color, blur: 15),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mode == TimerMode.chill ? 'CHILL MODE' : 'GRIND MODE',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: CyberpunkColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}

class NeonTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool isRunning;

  NeonTimerPainter({
    required this.progress,
    required this.color,
    this.isRunning = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;

    // Background circle (dim)
    final bgPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, bgPaint);

    // Outer glow ring
    final glowPaint = Paint()
      ..color = color.withOpacity(isRunning ? 0.4 : 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 20);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      glowPaint,
    );

    // Main neon arc
    final paint = Paint()
      ..color = color.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );

    // Inner bright line
    final innerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(NeonTimerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.isRunning != isRunning;
  }
}
