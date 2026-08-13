import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';

class PlayInstructionCard extends StatelessWidget {
  const PlayInstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.homeCardNavy,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.homeCardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Left Swap Icon Graphic ──────────────────────────────
            Container(
              width: 52,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.homeNavyDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryPurple.withValues(alpha: 0.5)),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.swipe_rounded,
                    color: AppColors.primaryPurpleLight,
                    size: 24,
                  ),
                  Positioned(
                    bottom: -6,
                    right: -4,
                    child: const Text('👆', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // ── Right Text Description ──────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Select a tile and tap another tile',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'to swap their positions',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
