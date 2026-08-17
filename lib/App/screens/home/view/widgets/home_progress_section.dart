import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/home_controller.dart';

class HomeProgressSection extends StatelessWidget {
  final HomeController controller;

  const HomeProgressSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final double percent = ctrl.progressPercent;
    final int percentInt = (percent * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            const Center(
              child: Text(
                'YOUR PROGRESS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // ── Stats Row ────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Stars Collected
                _StarsStat(
                  stars: ctrl.starsCollected,
                ),

                // Circular Progress Ring
                _CircularProgress(
                  percent: percent,
                  percentInt: percentInt,
                ),

                // Levels Completed
                _LevelsStat(
                  levelsCompleted: ctrl.levelsCompleted,
                  totalLevels: ctrl.totalLevels,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stars stat ────────────────────────────────────────────────────────────────
class _StarsStat extends StatelessWidget {
  final int stars;

  const _StarsStat({required this.stars});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 42),
        const SizedBox(height: 8),
        Text(
          '$stars',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Stars Collected',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Circular Progress Ring ────────────────────────────────────────────────────
class _CircularProgress extends StatelessWidget {
  final double percent;
  final int percentInt;

  const _CircularProgress({required this.percent, required this.percentInt});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 76,
          height: 76,
          child: CustomPaint(
            painter: _RingPainter(percent: percent),
            child: Center(
              child: Text(
                '$percentInt%',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Overall Progress',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent;
  const _RingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 6;
    const strokeWidth = 8.0;
    const startAngle = -math.pi / 2;

    // Background ring
    final bgPaint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final fgPaint = Paint()
      ..color = AppColors.homeProgressRing
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi * percent,
      false,
      fgPaint,
    );

    // Glow effect on progress end
    if (percent > 0.02) {
      final glowPaint = Paint()
        ..color = AppColors.homeProgressRing.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        2 * math.pi * percent,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.percent != percent;
}

// ── Levels stat ───────────────────────────────────────────────────────────────
class _LevelsStat extends StatelessWidget {
  final int levelsCompleted;
  final int totalLevels;

  const _LevelsStat({
    required this.levelsCompleted,
    required this.totalLevels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BlocksIcon(),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$levelsCompleted',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: ' / $totalLevels',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Levels Completed',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _BlocksIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 38,
      child: Stack(
        children: [
          // Bottom left block
          Positioned(
            bottom: 0,
            left: 2,
            child: _Block(color: AppColors.primaryPurple, size: 18),
          ),
          // Bottom right block
          Positioned(
            bottom: 0,
            right: 2,
            child: _Block(color: AppColors.primaryPurpleLight, size: 18),
          ),
          // Top center block
          Positioned(
            top: 0,
            left: 13,
            child: _Block(color: AppColors.primaryPurple, size: 18),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  final Color color;
  final double size;
  const _Block({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4),
        ],
      ),
    );
  }
}
