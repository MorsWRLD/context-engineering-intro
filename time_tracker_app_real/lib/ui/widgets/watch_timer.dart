import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/colors.dart';
import '../../models/session.dart';
import '../../core/timer/timer_state.dart';

class WatchTimer extends StatelessWidget {
  final Duration chillTime;
  final Duration grindTime;
  final Duration dayDuration; // For testing: 3 minutes
  final TimerMode currentMode;
  final TimerStatus timerStatus;
  
  const WatchTimer({
    Key? key,
    required this.chillTime,
    required this.grindTime,
    required this.currentMode,
    required this.timerStatus,
    this.dayDuration = const Duration(minutes: 3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chillProgress = chillTime.inSeconds / dayDuration.inSeconds;
    final grindProgress = grindTime.inSeconds / dayDuration.inSeconds;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer ring - Grind (Blue)
        CustomPaint(
          painter: CircleProgressPainter(
            progress: grindProgress.clamp(0.0, 1.0),
            color: CyberpunkColors.grindMode,
            strokeWidth: 12,
          ),
          size: const Size(280, 280),
        ),
        // Inner ring - Chill (Pink)
        CustomPaint(
          painter: CircleProgressPainter(
            progress: chillProgress.clamp(0.0, 1.0),
            color: CyberpunkColors.chillMode,
            strokeWidth: 12,
          ),
          size: const Size(240, 240),
        ),
        // Current time display
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getCurrentTime(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: CyberpunkColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            // Show mode when running
            if (timerStatus != TimerStatus.idle)
              Text(
                currentMode == TimerMode.chill ? 'CHILL' : 'GRIND',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: currentMode == TimerMode.chill
                      ? CyberpunkColors.chillMode
                      : CyberpunkColors.grindMode,
                ),
              ),
          ],
        ),
      ],
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${_pad(now.hour)}:${_pad(now.minute)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc with glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      glowPaint,
    );

    // Main arc
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
