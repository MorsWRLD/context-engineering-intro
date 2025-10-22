import 'package:flutter/material.dart';
import '../../models/session.dart';
import '../theme/colors.dart';

class ModeSelector extends StatelessWidget {
  final TimerMode selectedMode;
  final Function(TimerMode) onModeSelected;
  final bool enabled;

  const ModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ModeButton(
          mode: TimerMode.chill,
          isSelected: selectedMode == TimerMode.chill,
          onTap: () => onModeSelected(TimerMode.chill),
          enabled: enabled,
        ),
        const SizedBox(width: 24),
        _ModeButton(
          mode: TimerMode.grind,
          isSelected: selectedMode == TimerMode.grind,
          onTap: () => onModeSelected(TimerMode.grind),
          enabled: enabled,
        ),
      ],
    );
  }
}

class _ModeButton extends StatelessWidget {
  final TimerMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enabled;

  const _ModeButton({
    required this.mode,
    required this.isSelected,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final color = mode == TimerMode.chill
        ? CyberpunkColors.chillMode
        : CyberpunkColors.grindMode;

    final label = mode == TimerMode.chill ? 'CHILL' : 'GRIND';
    final multiplier = mode == TimerMode.chill ? '1x XP' : '2x XP';

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? CyberpunkColors.neonGlow(color, blur: 10) : null,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : CyberpunkColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              multiplier,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? color.withOpacity(0.8) : CyberpunkColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
