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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.homeCardNavy,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.homeCardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // ── Stats Row ────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Stars Collected
                _StarsStat(
                  stars: ctrl.starsCollected,
                  starsCollected: ctrl.starsCollected,
                  totalStars: ctrl.totalStars,
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
  final int starsCollected;
  final int totalStars;

  const _StarsStat({
    required this.stars,
    required this.starsCollected,
    required this.totalStars,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('⭐', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 6),
            Text(
              '$stars',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Stars Collected',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$starsCollected / $totalStars',
          style: const TextStyle(
            color: AppColors.accentGold,
            fontSize: 11,
            fontWeight: FontWeight.w700,
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
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: _RingPainter(percent: percent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$percentInt%',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'COMPLETE',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent;
  const _RingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;
    const strokeWidth = 10.0;
    const startAngle = -math.pi / 2;

    // Background ring
    final bgPaint = Paint()
      ..color = AppColors.homeCardBorder
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
        ..color = AppColors.homeProgressRing.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
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
      children: [
        // 3-block stack icon
        _BlocksIcon(),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$levelsCompleted',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: ' / $totalLevels',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Levels Completed',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
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
      width: 36,
      height: 36,
      child: Stack(
        children: [
          // Bottom left block
          Positioned(
            bottom: 0,
            left: 0,
            child: _Block(color: AppColors.primaryPurple, size: 18),
          ),
          // Bottom right block
          Positioned(
            bottom: 0,
            right: 0,
            child: _Block(color: AppColors.primaryPurpleLight, size: 18),
          ),
          // Top center block
          Positioned(
            top: 0,
            left: 9,
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
