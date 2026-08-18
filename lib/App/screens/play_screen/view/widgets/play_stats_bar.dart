import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/play_screen_controller.dart';

class PlayStatsBar extends StatelessWidget {
  final PlayScreenController controller;

  const PlayStatsBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── MOVES ──────────────────────────────────────────────
            Expanded(
              child: _StatItem(
                icon: Icons.swap_horiz_rounded,
                iconColor: AppColors.primaryCyan,
                label: 'MOVES',
                value: '${ctrl.moves}',
              ),
            ),

            _buildVerticalDivider(),

            // ── TIME ───────────────────────────────────────────────
            Expanded(
              child: _StatItem(
                icon: Icons.timer_rounded,
                iconColor: AppColors.playButtonGreen,
                label: 'TIME',
                value: ctrl.time,
              ),
            ),

            _buildVerticalDivider(),

            // ── BEST ───────────────────────────────────────────────
            Expanded(
              child: _StatItem(
                icon: Icons.emoji_events_rounded,
                iconColor: AppColors.accentGold,
                label: 'BEST',
                value: ctrl.bestTime,
                valueColor: AppColors.accentGold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 28,
      width: 1,
      color: const Color(0xFFE2E8F0),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color? valueColor;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
