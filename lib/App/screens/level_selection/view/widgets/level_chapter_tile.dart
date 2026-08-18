import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/routes/app_routes.dart';
import '../../repository/level_selection_repository.dart';

// List of relative coordinates (x, y) calibrated for full screen height alignment with the background image
// Exactly 10 slots distributed along the winding S-curve road
final List<Offset> mapNodeCoordinates = [
  const Offset(0.18, 0.19), // Level 1 (near cave/flag)
  const Offset(0.38, 0.23), // Level 2
  const Offset(0.58, 0.26), // Level 3
  const Offset(0.72, 0.31), // Level 4
  const Offset(0.64, 0.38), // Level 5
  const Offset(0.44, 0.42), // Level 6
  const Offset(0.30, 0.48), // Level 7
  const Offset(0.42, 0.54), // Level 8
  const Offset(0.62, 0.58), // Level 9
  const Offset(0.66, 0.67), // Level 10
];

class LevelGrid extends StatelessWidget {
  final List<LevelData> levels;

  const LevelGrid({
    super.key,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return _MapPage(
      levels: levels,
    );
  }
}

class _MapPage extends StatelessWidget {
  final List<LevelData> levels;

  const _MapPage({
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
              left: offset.dx * width - 21, // Node width is 42, half is 21
              top: offset.dy * height - 21, // Node height is 42
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  LevelCell(level: level),
                  // Green Flag on the first level of the current page/range
                  if (i == 0)
                    Positioned(
                      top: -24,
                      left: 15,
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
            width: 42,
            height: 42,
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
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: colors.border, width: 2.0),
            ),
            child: Center(
              child: level.state == LevelState.locked
                  ? const Icon(Icons.lock_rounded, color: Colors.white70, size: 16)
                  : Text(
                      '${level.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Color(0x66000000),
                            blurRadius: 4,
                            offset: Offset(0, 1.5),
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
