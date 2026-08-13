import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../binding/level_selection_binding.dart';
import '../controller/level_selection_controller.dart';
import 'widgets/level_top_bar.dart';
import 'widgets/level_chapter_tile.dart';

class LevelSelection extends StatekitView<LevelSelectionController>
    implements LevelSelectionBinding {
  LevelSelection({super.key, super.tag});

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
          ),
        ),
        child: StateBuilder<LevelSelectionController>(
          controller: controller,
          builder: (context, ctrl, child) {
            return SafeArea(
              child: Column(
                children: [
                  // ── Top Bar ──────────────────────────────────────
                  LevelTopBar(controller: ctrl),

                  const SizedBox(height: 6),

                  // ── Levels Grid ──────────────────────────────────
                  Expanded(child: LevelGrid(levels: ctrl.levels)),

                  const SizedBox(height: 4),
                ],
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
