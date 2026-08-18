import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';
import '../../base_screen/view/base_screen.dart';
import '../../base_screen/view/custom_appbar.dart';
import '../binding/settings_screen_binding.dart';
import '../controller/settings_screen_controller.dart';

class SettingsScreen extends StatekitView<SettingsScreenController>
    implements SettingsScreenBinding {
  SettingsScreen({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      useGradientBackground: false,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(titleText: 'SETTINGS'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StateBuilder<SettingsScreenController>(
          controller: controller,
          builder: (context, ctrl, child) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // ── Card 1: Game Settings ───────────────────────────────
                    _buildSettingsCard(
                      title: 'GAME SETTINGS',
                      children: [
                        _buildToggleRow(
                          title: 'Sound Effects',
                          subtitle: 'SFX sounds in menus and gameplay',
                          value: ctrl.isSoundEnabled,
                          onTap: ctrl.toggleSound,
                        ),
                        _buildDivider(),
                        _buildToggleRow(
                          title: 'Music track',
                          subtitle: 'Casual ambient game music',
                          value: ctrl.isMusicEnabled,
                          onTap: ctrl.toggleMusic,
                        ),
                        _buildDivider(),
                        _buildToggleRow(
                          title: 'Vibration',
                          subtitle: 'Haptic feedback on tile drops',
                          value: ctrl.isVibrationEnabled,
                          onTap: ctrl.toggleVibration,
                        ),
                        _buildDivider(),
                        _buildActionRow(
                          title: 'Language',
                          subtitle: 'Switch application language',
                          trailingText: ctrl.currentLanguage,
                          onTap: () => _showLanguageModal(context, ctrl),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Card 2: Support & Info ──────────────────────────────
                    _buildSettingsCard(
                      title: 'SUPPORT & COMMUNITY',
                      children: [
                        _buildLinkRow(
                          title: 'How to Play',
                          subtitle: 'View puzzle gameplay tutorial instructions',
                          icon: Icons.help_outline_rounded,
                          iconColor: AppColors.primaryPurpleLight,
                          onTap: () => _showTutorialDialog(context),
                        ),
                        _buildDivider(),
                        _buildLinkRow(
                          title: 'Rate Block Puzzle',
                          subtitle: 'Share your feedback on the App Store',
                          icon: Icons.star_border_rounded,
                          iconColor: AppColors.accentGold,
                          onTap: () => _showRatingToast(context),
                        ),
                        _buildDivider(),
                        _buildLinkRow(
                          title: 'Privacy Policy',
                          subtitle: 'Review personal data guidelines',
                          icon: Icons.shield_outlined,
                          iconColor: AppColors.primaryCyan,
                          onTap: () {},
                        ),
                        _buildDivider(),
                        _buildLinkRow(
                          title: 'Terms of Service',
                          subtitle: 'View software end-user agreement',
                          icon: Icons.description_outlined,
                          iconColor: const Color(0xFF64748B),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    // ── Version & Footer ────────────────────────────────────
                    const Text(
                      'v1.0.4 (42) • Block Puzzle Pro',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Built with Unity-style Flutter ❤️',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Premium Unity-style Toggle Button (ON / OFF)
        UnityButton(
          width: 60,
          height: 32,
          borderRadius: 10.0,
          borderWidth: 1.0,
          shadowHeight: 2.0,
          baseColor: value ? const Color(0xFF10B981) : const Color(0xFF94A3B8), // Green or Grey
          shadowColor: value ? const Color(0xFF047857) : const Color(0xFF475569),
          gradientColors: value
              ? const [Color(0xFF34D399), Color(0xFF10B981)]
              : const [Color(0xFFCBD5E1), Color(0xFF94A3B8)],
          onTap: onTap,
          child: Center(
            child: Text(
              value ? 'ON' : 'OFF',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow({
    required String title,
    required String subtitle,
    required String trailingText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trailingText,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFFCBD5E1),
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(color: Color(0xFFF1F5F9), height: 1),
    );
  }

  void _showLanguageModal(BuildContext context, SettingsScreenController ctrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final languages = ['English', 'Español', 'Français', 'Deutsch', '日本語'];
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1.5)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'SELECT LANGUAGE',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                ...languages.map((lang) {
                  final isSelected = ctrl.currentLanguage == lang;
                  return ListTile(
                    onTap: () {
                      ctrl.setLanguage(lang);
                      Navigator.pop(context);
                    },
                    title: Text(
                      lang,
                      style: TextStyle(
                        color: isSelected ? AppColors.primaryPurple : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryPurple)
                        : null,
                  );
                }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'HOW TO PLAY',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 16),
              _buildTutorialStep('1', 'Drag and drop blocks to arrange the tiles on the 4x4 board.'),
              const SizedBox(height: 12),
              _buildTutorialStep('2', 'Sort and align similar color hues to complete gradients.'),
              const SizedBox(height: 12),
              _buildTutorialStep('3', 'Clear levels in the fewest moves to earn 3 Golden Stars!'),
              const SizedBox(height: 24),
              UnityButton(
                width: double.infinity,
                height: 48,
                borderRadius: 14.0,
                borderWidth: 1.5,
                shadowHeight: 3.0,
                baseColor: AppColors.primaryPurple,
                shadowColor: const Color(0xFF4338CA),
                gradientColors: AppColors.primaryGradient,
                onTap: () => Navigator.pop(context),
                child: const Center(
                  child: Text(
                    'GOT IT!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialStep(String step, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primaryPurple,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _showRatingToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Thank you for rating Block Puzzle!',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.playButtonGreen,
      ),
    );
  }

  @override
  void doSomething() {}
}
