import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../binding/play_screen_binding.dart';
import '../controller/play_screen_controller.dart';
import 'widgets/play_top_bar.dart';
import 'widgets/play_stats_bar.dart';
import 'widgets/play_grid_board.dart';
import 'widgets/level_complete_dialog.dart';

class PlayScreen extends StatekitView<PlayScreenController> implements PlayScreenBinding {
  PlayScreen({super.key, super.tag});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home-background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: StateBuilder<PlayScreenController>(
            controller: controller,
            builder: (context, ctrl, child) {
              if (ctrl.puzzle == null) {
                return const SafeArea(
                  child: Center(child: CircularProgressIndicator(color: AppColors.accentGold)),
                );
              }

              debugPrint(ctrl.currentTiles.map((e) => e.id).toString());

              return SafeArea(
                child: Column(
                  children: [
                    // ── Top Bar ──────────────────────────────────────────
                    PlayTopBar(controller: ctrl),

                    const SizedBox(height: 4),

                    // ── Game Stats Bar ──────────────────────────────────
                    PlayStatsBar(controller: ctrl),

                    const SizedBox(height: 4),

                    // ── 4x4 Grid Board ──────────────────────────────────
                    Expanded(
                      child: PlayGridBoard(controller: ctrl),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void puzzleComplete() {
    LevelCompleteDialog.show(context, controller);
  }
}
