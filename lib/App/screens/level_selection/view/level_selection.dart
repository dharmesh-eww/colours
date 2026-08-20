import 'package:statekit/statekit.dart';
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import '../binding/level_selection_binding.dart';
import '../controller/level_selection_controller.dart';
import 'widgets/level_chapter_tile.dart';

class LevelSelection extends StatekitView<LevelSelectionController>
    implements LevelSelectionBinding {
  LevelSelection({super.key, super.tag});

  @override
  void initState() {
    super.initState();
    controller.scrollToActiveLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDCFCE7), // Meadow base background color
      child: StateBuilder<LevelSelectionController>(
        controller: controller,
        builder: (context, ctrl, child) {
          return Stack(
            children: [
              // 1. Smooth Scrollable Roadmap
              Positioned.fill(
                child: ListView.builder(
                  controller: ctrl.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: ctrl.levels.length,
                  reverse: true, // Level 1 is at the bottom, winds upward
                  itemBuilder: (context, index) {
                    final level = ctrl.levels[index];
                    return MapRoadTile(
                      index: index,
                      level: level,
                      isLast: index == ctrl.levels.length - 1,
                    );
                  },
                ),
              ),

              // 2. Safe Area HUD Title Overlay (Ignored pointer so clicks go to nodes underneath)
              SafeArea(
                child: IgnorePointer(
                  ignoring: true,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // LEVELS Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Left block decors
                          const _TitleBlock(color: Color(0xFFF97316)), // Orange
                          const SizedBox(width: 6),
                          const _TitleBlock(color: Color(0xFF3B82F6)), // Blue
                          const SizedBox(width: 14),
                          const Text(
                            'LEVELS',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 10,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Right block decors
                          const _TitleBlock(color: Color(0xFF10B981)), // Green
                          const SizedBox(width: 6),
                          const _TitleBlock(color: Color(0xFF3B82F6)), // Blue
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                        ),
                        child: const Text(
                          'Scroll Up for New Worlds',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. SHOP Button (bottom-left overlay)
              Positioned(
                left: 16,
                bottom: 24,
                child: const _OverlayCardButton(
                  label: 'SHOP',
                  iconWidget: Icon(
                    Icons.storefront_rounded,
                    color: Color(0xFFEF4444),
                    size: 24,
                  ),
                ),
              ),

              // 4. DAILY Button (bottom-right overlay)
              Positioned(
                right: 16,
                bottom: 24,
                child: const _OverlayCardButton(
                  label: 'DAILY',
                  iconWidget: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFBBF24),
                    size: 24,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void doSomething() {}
}

class _TitleBlock extends StatelessWidget {
  final Color color;
  const _TitleBlock({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 3,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
    );
  }
}

class _OverlayCardButton extends StatelessWidget {
  final String label;
  final Widget iconWidget;

  const _OverlayCardButton({
    required this.label,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
