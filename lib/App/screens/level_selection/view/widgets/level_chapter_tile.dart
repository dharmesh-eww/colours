import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/routes/app_routes.dart';
import '../../repository/level_selection_repository.dart';

// List of relative coordinates (x, y) calibrated for full screen height alignment with the background image
final List<Offset> mapNodeCoordinates = [
  const Offset(0.18, 0.19), // Level 1 (near cave/flag)
  const Offset(0.31, 0.22), // Level 2
  const Offset(0.44, 0.24), // Level 3
  const Offset(0.57, 0.26), // Level 4
  const Offset(0.70, 0.29), // Level 5
  const Offset(0.76, 0.35), // Level 6
  const Offset(0.66, 0.38), // Level 7
  const Offset(0.54, 0.40), // Level 8
  const Offset(0.41, 0.43), // Level 9
  const Offset(0.30, 0.47), // Level 10
  const Offset(0.33, 0.53), // Level 11
  const Offset(0.45, 0.55), // Level 12
  const Offset(0.57, 0.58), // Level 13
  const Offset(0.69, 0.61), // Level 14
  const Offset(0.63, 0.69), // Level 15
  const Offset(0.49, 0.72), // Level 16
];

class LevelGrid extends StatelessWidget {
  final List<LevelData> levels;
  final ValueChanged<int> onPageChanged;

  const LevelGrid({
    super.key,
    required this.levels,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Total pages = (levels.length / 16).ceil()
    final int pageCount = (levels.length / 16).ceil();

    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: pageCount,
      onPageChanged: onPageChanged,
      itemBuilder: (context, pageIndex) {
        final int startIndex = pageIndex * 16;
        final int endIndex = math.min(startIndex + 16, levels.length);
        final pageLevels = levels.sublist(startIndex, endIndex);

        return _MapPage(
          pageIndex: pageIndex,
          levels: pageLevels,
        );
      },
    );
  }
}

class _MapPage extends StatelessWidget {
  final int pageIndex;
  final List<LevelData> levels;

  const _MapPage({
    required this.pageIndex,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        return Stack(
          clipBehavior: Clip.none,
          children: List.generate(levels.length, (i) {
            final level = levels[i];
            final offset = mapNodeCoordinates[i];

            return Positioned(
              left: offset.dx * width - 28, // Node width is 56, half is 28
              top: offset.dy * height - 28, // Node height is 56
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  LevelCell(level: level),
                  // Green Flag on Level 1 of Page 1
                  if (pageIndex == 0 && level.number == 1)
                    Positioned(
                      top: -30,
                      left: 22,
                      child: _LevelFlag(),
                    ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

// ── Level Cell Node ───────────────────────────────────────────────────────────
class LevelCell extends StatelessWidget {
  final LevelData level;
  const LevelCell({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final colors = _colorsForState(level.state);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.playScreen, arguments: level.number);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors.gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow,
                  blurRadius: 0,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: colors.border, width: 2.5),
            ),
            child: Center(
              child: level.state == LevelState.locked
                  ? const Icon(Icons.lock_rounded, color: Colors.white70, size: 20)
                  : Text(
                      '${level.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Color(0x66000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          _StarsRow(earned: level.starsEarned, state: level.state),
        ],
      ),
    );
  }

  _CellColors _colorsForState(LevelState state) {
    switch (state) {
      case LevelState.completed:
        return const _CellColors(
          gradient: [Color(0xFF56C656), Color(0xFF3A9A3A)],
          shadow: Color(0xFF2A7A2A),
          border: Color(0xFF6ED36E),
        );
      case LevelState.current:
        return const _CellColors(
          gradient: [Color(0xFF5B9BD5), Color(0xFF3A78B5)],
          shadow: Color(0xFF2A5A8A),
          border: Color(0xFF7BBAF5),
        );
      case LevelState.locked:
        return const _CellColors(
          gradient: [Color(0xFF94A3B8), Color(0xFF64748B)],
          shadow: Color(0xFF475569),
          border: Color(0xFFCBD5E1),
        );
    }
  }
}

class _CellColors {
  final List<Color> gradient;
  final Color shadow;
  final Color border;
  const _CellColors({required this.gradient, required this.shadow, required this.border});
}

class _StarsRow extends StatelessWidget {
  final int earned;
  final LevelState state;
  const _StarsRow({required this.earned, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state == LevelState.locked) {
      return const SizedBox(height: 12);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final isFilled = i < earned;
        return Icon(
          Icons.star_rounded,
          color: isFilled ? AppColors.accentGold : const Color(0x55FFFFFF),
          size: 12,
        );
      }),
    );
  }
}

// ── Flag Banner ───────────────────────────────────────────────────────────────
class _LevelFlag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/flag.png',
      width: 38,
      height: 38,
    );
  }
}
