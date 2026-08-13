import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/routes/app_routes.dart';
import '../binding/home_binding.dart';
import '../controller/home_controller.dart';
import 'widgets/home_top_bar.dart';
import 'widgets/home_game_logo.dart';
import 'widgets/home_play_button.dart';
import 'widgets/home_feature_cards.dart';
import 'widgets/home_progress_section.dart';

class Home extends StatekitView<HomeController> implements HomeBinding {
  Home({super.key, super.tag});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.playScreenGradient,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: StateBuilder<HomeController>(
          controller: controller,
          builder: (context, ctrl, child) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // ── Top Stats Bar ──────────────────────────────────
                    HomeTopBar(controller: ctrl),

                    const SizedBox(height: 20),

                    // ── Decorative block shapes (background) ───────────
                    _buildDecorativeBlocks(),

                    const SizedBox(height: 8),

                    // ── Game Logo ──────────────────────────────────────
                    const HomeGameLogo(),

                    const SizedBox(height: 28),

                    // ── PLAY Button ────────────────────────────────────
                    HomePlayButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.playScreen,
                          arguments: ctrl.playerLevel,
                        );
                      },
                    ),

                    const SizedBox(height: 22),

                    // ── Feature Cards ──────────────────────────────────
                    HomeFeatureCards(controller: ctrl),

                    const SizedBox(height: 16),

                    // ── Progress Section ───────────────────────────────
                    HomeProgressSection(controller: ctrl),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDecorativeBlocks() {
    return SizedBox(
      height: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle floating block squares in background
          Positioned(
            left: 20,
            child: _DecorBlock(
              color: AppColors.primaryPurple.withValues(alpha: 0.3),
              size: 18,
              rotation: 0.4,
            ),
          ),
          Positioned(
            right: 30,
            child: _DecorBlock(
              color: AppColors.accentGold.withValues(alpha: 0.25),
              size: 14,
              rotation: -0.3,
            ),
          ),
          Positioned(
            left: 80,
            top: 2,
            child: _DecorBlock(
              color: const Color(0xFF27AE60).withValues(alpha: 0.25),
              size: 10,
              rotation: 0.6,
            ),
          ),
          Positioned(
            right: 90,
            top: 4,
            child: _DecorBlock(
              color: const Color(0xFF3498DB).withValues(alpha: 0.25),
              size: 12,
              rotation: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void doSomething() {}
}

class _DecorBlock extends StatelessWidget {
  final Color color;
  final double size;
  final double rotation;

  const _DecorBlock({required this.color, required this.size, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
