import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/play_screen_controller.dart';

class PlayActionControls extends StatelessWidget {
  final PlayScreenController controller;

  const PlayActionControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // ── UNDO ─────────────────────────────────────────────────
          Expanded(
            child: _ActionButton(
              icon: Icons.undo_rounded,
              iconColor: AppColors.primaryPurpleLight,
              label: 'UNDO',
              badgeCount: ctrl.undoCount,
              badgeColor: AppColors.primaryPurple,
              onTap: ctrl.onUndo,
            ),
          ),

          const SizedBox(width: 8),

          // ── HINT ─────────────────────────────────────────────────
          Expanded(
            child: _ActionButton(
              icon: Icons.lightbulb_rounded,
              iconColor: AppColors.accentGold,
              label: 'HINT',
              badgeCount: ctrl.hintCount,
              badgeColor: AppColors.accentGold,
              badgeTextColor: Colors.black,
              onTap: ctrl.onHint,
            ),
          ),

          const SizedBox(width: 8),

          // ── RESTART ──────────────────────────────────────────────
          Expanded(
            child: _ActionButton(
              icon: Icons.refresh_rounded,
              iconColor: AppColors.primaryCyan,
              label: 'RESTART',
              onTap: ctrl.onRestart,
            ),
          ),

          const SizedBox(width: 8),

          // ── SHUFFLE ──────────────────────────────────────────────
          Expanded(
            child: _ActionButton(
              icon: Icons.shuffle_rounded,
              iconColor: AppColors.playButtonGreen,
              label: 'SHUFFLE',
              badgeCount: ctrl.shuffleCount,
              badgeColor: AppColors.playButtonGreen,
              onTap: ctrl.onShuffle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int? badgeCount;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.badgeCount,
    this.badgeColor,
    this.badgeTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.homeCardNavy,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.homeCardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            if (badgeCount != null) ...[
              const SizedBox(height: 6),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: badgeColor ?? AppColors.primaryPurple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$badgeCount',
                    style: TextStyle(
                      color: badgeTextColor ?? Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
