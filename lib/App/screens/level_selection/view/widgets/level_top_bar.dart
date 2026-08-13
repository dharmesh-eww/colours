import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/level_selection_controller.dart';

class LevelTopBar extends StatelessWidget {
  final LevelSelectionController controller;
  const LevelTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          // ── Back arrow ──────────────────────────────────────────
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.homeCardNavy,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.homeCardBorder, width: 1),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),

          // ── LEVELS title ────────────────────────────────────────
          const Text(
            'LEVELS',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),

          const Spacer(),

          // ── Stars chip ──────────────────────────────────────────
          _TopChip(
            emoji: '⭐',
            value: '${ctrl.starsCollected} / ${ctrl.totalStars}',
          ),
          const SizedBox(width: 8),

          // ── Coins chip ──────────────────────────────────────────
          _TopChip(
            emoji: '🪙',
            value: '${ctrl.coins}',
            showPlus: true,
          ),
        ],
      ),
    );
  }
}

class _TopChip extends StatelessWidget {
  final String emoji;
  final String value;
  final bool showPlus;
  const _TopChip({required this.emoji, required this.value, this.showPlus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.homeCardNavy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.homeCardBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showPlus) ...[
            const SizedBox(width: 4),
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.playButtonGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 11),
            ),
          ],
        ],
      ),
    );
  }
}
