import 'package:colours/App/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:statekit/statekit.dart';
import 'package:colours/App/core/constants/avatar_data.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';
import '../binding/profile_binding.dart';
import '../controller/profile_controller.dart';

class Profile extends StatekitView<ProfileController> implements ProfileBinding {
  Profile({super.key, super.tag});

  @override
  void initState() {
    super.initState();
    controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home-background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: StateBuilder<ProfileController>(
        controller: controller,
        builder: (context, ctrl, child) {
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
          }

          final profile = ctrl.userProfile;
          final avatar = AvatarData.getAvatar(profile.avatarId);

          // Handler to navigate to edit screen
          Future<void> navigateToEdit() async {
            final result = await Navigator.pushNamed(context, Routes.profileEdit);
            if (result == true) {
              ctrl.loadProfile();
            }
          }

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  // ── Top Bar Header ────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'PROFILE',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Hero Avatar & Country Card ───────────────────────────
                  Column(
                    children: [
                      // Hero Avatar Container
                      GestureDetector(
                        onTap: navigateToEdit,
                        behavior: HitTestBehavior.opaque,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: avatar.gradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: avatar.gradient.first.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Icon(avatar.icon, color: avatar.iconColor, size: 52),
                            ),
                            // Country Flag Badge
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Text(
                                profile.countryFlag,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Hero Username
                      GestureDetector(
                        onTap: navigateToEdit,
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          profile.username,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Country Name & Code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(profile.countryFlag, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Text(
                            '${profile.countryName} (${profile.countryCode})',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      if (profile.isGoogleSignedIn && profile.userEmail != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.playButtonGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.playButtonGreen.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.playButtonGreen,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                profile.userEmail!,
                                style: const TextStyle(
                                  color: AppColors.playButtonGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 18),

                      // Google Sign-In Button inside card
                      UnityButton(
                        width: 220,
                        height: 48,
                        borderRadius: 16.0,
                        borderWidth: 1.5,
                        shadowHeight: 4.0,
                        baseColor: profile.isGoogleSignedIn
                            ? const Color(0xFFFCA5A5)
                            : Colors.white,
                        shadowColor: profile.isGoogleSignedIn
                            ? const Color(0xFFEF4444)
                            : const Color(0xFFE2E8F0),
                        gradientColors: profile.isGoogleSignedIn
                            ? const [Color(0xFFFEF2F2), Color(0xFFFEE2E2)]
                            : const [Colors.white, Color(0xFFF8FAFC)],
                        onTap: ctrl.toggleGoogleSignIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google_logo.png',
                              width: 22,
                              height: 22,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.g_mobiledata_rounded,
                                  color: Colors.redAccent,
                                  size: 28,
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            Text(
                              profile.isGoogleSignedIn
                                  ? 'Sign Out Google Account'
                                  : 'Sign in with Google',
                              style: TextStyle(
                                color: profile.isGoogleSignedIn
                                    ? const Color(0xFFB91C1C)
                                    : const Color(0xFF1F2937),
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Quick Game Stats Card ───────────────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          'LEVEL',
                          '24',
                          Icons.military_tech_rounded,
                          AppColors.accentGold,
                        ),
                        Container(width: 1, height: 40, color: AppColors.divider),
                        _buildStatItem(
                          'STARS',
                          '72 ⭐',
                          Icons.star_rounded,
                          AppColors.primaryPurpleLight,
                        ),
                        Container(width: 1, height: 40, color: AppColors.divider),
                        _buildStatItem(
                          'RANK',
                          '#42',
                          Icons.leaderboard_rounded,
                          AppColors.primaryCyan,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  @override
  void doSomething() {}
}
