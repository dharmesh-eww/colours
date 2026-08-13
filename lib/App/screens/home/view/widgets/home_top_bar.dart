import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/home_controller.dart';

class HomeTopBar extends StatelessWidget {
  final HomeController controller;

  const HomeTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Player avatar + name + level ─────────────────────────
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.homeCardNavy,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.homeCardBorder, width: 1),
              ),
              child: Row(
                children: [
                  // Crown avatar
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9B59B6), Color(0xFF6C3483)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: AppColors.accentGold, width: 2),
                    ),
                    child: const Center(
                      child: Text('👑', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Name + level + progress bar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ctrl.playerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Level label
                        Text(
                          'Level ${ctrl.playerLevel}',
                          style: const TextStyle(
                            color: AppColors.accentGold,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Progress bar full-width
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ctrl.levelProgress,
                            backgroundColor: AppColors.homeCardBorder,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.accentGold),
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // ── Stars chip ──────────────────────────────────────────
          _StatChip(
            emoji: '⭐',
            value: '${ctrl.starsCollected}/${ctrl.totalStars}',
          ),

          const SizedBox(width: 6),

          // ── Coins chip ──────────────────────────────────────────
          _StatChip(
            emoji: '🪙',
            value: '${ctrl.coins}',
            showPlus: true,
          ),

          const SizedBox(width: 6),

          // ── Settings ────────────────────────────────────────────
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.homeCardNavy,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.homeCardBorder, width: 1),
            ),
            child: const Icon(
              Icons.settings_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String emoji;
  final String value;
  final bool showPlus;

  const _StatChip({
    required this.emoji,
    required this.value,
    this.showPlus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.homeCardNavy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.homeCardBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 3),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showPlus) ...[
            const SizedBox(width: 3),
            Container(
              width: 15,
              height: 15,
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
