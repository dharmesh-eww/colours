import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../../controller/home_controller.dart';

class HomeFeatureCards extends StatelessWidget {
  final HomeController controller;

  const HomeFeatureCards({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // ── Daily Challenge ──────────────────────────────────────
          Expanded(
            child: _FeatureCard(
              iconWidget: _CalendarIcon(),
              title: 'DAILY CHALLENGE',
              subtitle: '⏱ ${ctrl.dailyChallengeTimeLeft}',
              subtitleColor: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 10),

          // ── Achievements ─────────────────────────────────────────
          Expanded(
            child: _FeatureCard(
              iconWidget: const _TrophyIcon(),
              title: 'ACHIEVEMENTS',
              subtitle:
                  '${ctrl.achievementsUnlocked} / ${ctrl.totalAchievements}',
              subtitleColor: AppColors.accentGold,
            ),
          ),
          const SizedBox(width: 10),

          // ── Statistics ───────────────────────────────────────────
          Expanded(
            child: _FeatureCard(
              iconWidget: const _StatsIcon(),
              title: 'STATISTICS',
              subtitle: 'View your progress',
              subtitleColor: AppColors.primaryPurpleLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final Widget iconWidget;
  final String title;
  final String subtitle;
  final Color subtitleColor;

  const _FeatureCard({
    required this.iconWidget,
    required this.title,
    required this.subtitle,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: subtitleColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Icon Widgets ─────────────────────────────────────────────────────────────

class _CalendarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2E4A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.calendar_month_rounded,
              color: Color(0xFF5B9BD5), size: 34),
          Positioned(
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.accentGold,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 8),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrophyIcon extends StatelessWidget {
  const _TrophyIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A1A00), Color(0xFF1A1000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: const Icon(
        Icons.emoji_events_rounded,
        color: AppColors.accentGold,
        size: 36,
      ),
    );
  }
}

class _StatsIcon extends StatelessWidget {
  const _StatsIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A0A2E), Color(0xFF10062A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: const Icon(
        Icons.bar_chart_rounded,
        color: AppColors.primaryPurpleLight,
        size: 36,
      ),
    );
  }
}
