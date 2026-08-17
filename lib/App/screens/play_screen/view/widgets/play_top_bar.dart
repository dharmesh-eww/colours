import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';
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
          UnityButton(
            width: 44,
            height: 44,
            borderRadius: 14.0,
            borderWidth: 1.0,
            shadowHeight: 4.0,
            baseColor: AppColors.homeCardNavy,
            shadowColor: const Color(0xFFCBD5E1),
            gradientColors: const [Colors.white, Color(0xFFF1F5F9)],
            onTap: () => Navigator.maybePop(context),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
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
          UnityButton(
            width: 44,
            height: 44,
            borderRadius: 14.0,
            borderWidth: 1.0,
            shadowHeight: 4.0,
            baseColor: AppColors.homeCardNavy,
            shadowColor: const Color(0xFFCBD5E1),
            gradientColors: const [Colors.white, Color(0xFFF1F5F9)],
            onTap: ctrl.onRestart,
            child: const Icon(
              Icons.refresh_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
