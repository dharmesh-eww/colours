import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-background.png'),
            fit: BoxFit.cover,
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

                    const SizedBox(height: 18),

                    // ── Game Logo ──────────────────────────────────────
                    const HomeGameLogo(),

                    const SizedBox(height: 24),

                    // ── PLAY Button platform ───────────────────────────
                    HomePlayButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.playScreen,
                          arguments: ctrl.playerLevel,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // ── Feature Cards ──────────────────────────────────
                    HomeFeatureCards(controller: ctrl),

                    const SizedBox(height: 24),

                    // ── Progress Section ───────────────────────────────
                    HomeProgressSection(controller: ctrl),

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

  @override
  void doSomething() {}
}
