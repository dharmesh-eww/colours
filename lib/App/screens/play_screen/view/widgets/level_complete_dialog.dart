import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/play_screen_controller.dart';

class LevelCompleteDialog extends StatelessWidget {
  final PlayScreenController controller;

  const LevelCompleteDialog({super.key, required this.controller});

  static Future<void> show(BuildContext context, PlayScreenController controller) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LevelCompleteDialog(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final int minMoves = ctrl.puzzle?.minMoves ?? 10;
    final int starsEarned = ctrl.moves <= minMoves
        ? 3
        : (ctrl.moves <= (minMoves * 1.5).round() ? 2 : 1);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.accentGold, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentGold.withValues(alpha: 0.35),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Trophy Icon Header ──────────────────────────────────────
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.accentGold, Color(0xFFFF8F00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGold.withValues(alpha: 0.5),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 42),
            ),

            const SizedBox(height: 16),

            // ── Title ──────────────────────────────────────────────────
            const Text(
              'LEVEL COMPLETE!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Level ${ctrl.currentLevel} Solved Perfectly',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            // ── Stars Row ──────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final bool isEarned = index < starsEarned;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.star_rounded,
                    color: isEarned ? AppColors.accentGold : AppColors.divider,
                    size: 36,
                  ),
                );
              }),
            ),

            const SizedBox(height: 18),

            // ── Stats Box ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.homeNavyDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('MOVES', '${ctrl.moves}'),
                  Container(width: 1, height: 24, color: AppColors.divider),
                  _buildStatItem('TARGET', '$minMoves'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Next Level Action Button ──────────────────────────────
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                ctrl.loadNextLevel();
              },
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF56C656), Color(0xFF2E7D32)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF56C656).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFF81C784), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'NEXT LEVEL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 24),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Replay Button ──────────────────────────────────────────
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ctrl.onRestart();
              },
              child: Text(
                'REPLAY LEVEL',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
