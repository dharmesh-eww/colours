import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/play_screen_controller.dart';

class PlayTopBar extends StatelessWidget {
  final PlayScreenController controller;

  const PlayTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final puzzle = ctrl.puzzle;

    if (puzzle == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Back Button ─────────────────────────────────────────
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.homeCardNavy,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.homeCardBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),

          // ── Title ───────────────────────────────────────────────
          Expanded(
            child: Text(
              'LEVEL ${puzzle.levelNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // ── Restart Button ──────────────────────────────────────
          GestureDetector(
            onTap: ctrl.onRestart,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.homeCardNavy,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.homeCardBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.refresh_rounded,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
