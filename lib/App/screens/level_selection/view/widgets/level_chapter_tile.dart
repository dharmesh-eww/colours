import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/routes/app_routes.dart';
import '../../repository/level_selection_repository.dart';

// Helper to calculate the horizontal coordinates for a level cell based on index
double getXOffsetForIndex(int index, double screenWidth) {
  final double center = screenWidth * 0.5;
  // Amplitude limits the curve so nodes stay inside a safe horizontal range
  final double amplitude = screenWidth * 0.24;
  // Serpentine wave frequency
  final double frequency = 0.5;
  return center + amplitude * math.sin(index * frequency);
}

// Biome decoration calculator based on level progress, using solid colors and gradients at boundaries
BoxDecoration getBiomeDecoration(int index) {
  const Color meadow = Color(0xFFDCFCE7);
  const Color desert = Color(0xFFFEF3C7);
  const Color forest = Color(0xFFF3E8FF);
  const Color ice = Color(0xFFECFDF5);
  const Color cave = Color(0xFFEFF6FF);

  if (index == 99) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [meadow, desert],
      ),
    );
  } else if (index == 199) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [desert, forest],
      ),
    );
  } else if (index == 299) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [forest, ice],
      ),
    );
  } else if (index == 399) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [ice, cave],
      ),
    );
  }

  // Return solid color per biome block to eliminate horizontal lines
  Color color = meadow;
  if (index < 100) {
    color = meadow;
  } else if (index < 200) {
    color = desert;
  } else if (index < 300) {
    color = forest;
  } else if (index < 400) {
    color = ice;
  } else {
    color = cave;
  }
  return BoxDecoration(color: color);
}

class MapRoadTile extends StatelessWidget {
  final int index;
  final LevelData level;
  final bool isLast;

  const MapRoadTile({
    super.key,
    required this.index,
    required this.level,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        final double x = getXOffsetForIndex(index, w);

        return Container(
          height: 120.0,
          width: double.infinity,
          decoration: getBiomeDecoration(index),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Serpentine Winding Road Painter (with explicit screen width passed)
              Positioned.fill(
                child: CustomPaint(
                  painter: RoadPainter(index: index, isLast: isLast, screenWidth: w),
                ),
              ),

              // 2. Dynamic Side Decorations
              _buildDecorations(context, index, w),

              // 3. Level Cell Node
              Positioned(
                left: x - 21, // LevelCell size is 42, half is 21
                top: 60.0 - 21, // Center vertically
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    LevelCell(level: level),
                    // Green flag banner on the player's active current level cell
                    if (level.state == LevelState.current)
                      Positioned(
                        top: -24,
                        left: 15,
                        child: Image.asset(
                          'assets/images/flag.png',
                          width: 38,
                          height: 38,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDecorations(BuildContext context, int idx, double w) {
    final bool curveIsRight = math.sin(idx * 0.5) > 0;
    final double leftOffset = curveIsRight ? 45.0 : w - 95.0;

    String assetPath = 'assets/images/tree_leafy.png';
    double size = 48.0;

    if (idx % 10 == 9) {
      assetPath = 'assets/images/chest.png';
      size = 40.0;
    } else if (idx % 15 == 7) {
      assetPath = 'assets/images/block_3d.png';
      size = 38.0;
    } else if (idx % 2 == 0) {
      assetPath = 'assets/images/tree_pine.png';
      size = 48.0;
    }

    return Positioned(
      left: leftOffset,
      top: 36.0, // Vertically centered inside the 120px tall tile
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
      ),
    );
  }
}

class RoadPainter extends CustomPainter {
  final int index;
  final bool isLast;
  final double screenWidth;

  RoadPainter({
    required this.index,
    required this.isLast,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = screenWidth;

    // Calculate coordinates of current node i, prev node i-1, and next node i+1
    final double xCurrent = getXOffsetForIndex(index, w);
    final double xPrev = index > 0 ? getXOffsetForIndex(index - 1, w) : xCurrent;
    final double xNext = !isLast ? getXOffsetForIndex(index + 1, w) : xCurrent;

    // Calculate boundary start and end x-coordinates for perfect continuity
    final double xStart = (xCurrent + xPrev) / 2;
    final double xEnd = (xCurrent + xNext) / 2;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFF59E0B).withValues(alpha: 0.8) // Road border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 34.0
      ..strokeCap = StrokeCap.round;

    final Paint roadPaint = Paint()
      ..color = const Color(0xFFFEF08A) // Sandy yellow inner path
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    path.moveTo(xStart, 120.0);

    // Smooth Bezier from bottom-to-center
    path.cubicTo(
      xStart, 90.0,
      xCurrent, 90.0,
      xCurrent, 60.0,
    );

    // Smooth Bezier from center-to-top
    path.cubicTo(
      xCurrent, 30.0,
      xEnd, 30.0,
      xEnd, 0.0,
    );

    // Render road border and inside road surface
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, roadPaint);

    // Render dashed center-line
    final Paint centerLinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      const double dashLength = 6.0;
      const double spaceLength = 6.0;
      while (distance < metric.length) {
        final Path extract = metric.extractPath(distance, distance + dashLength);
        canvas.drawPath(extract, centerLinePaint);
        distance += dashLength + spaceLength;
      }
    }
  }

  @override
  bool shouldRepaint(RoadPainter oldDelegate) =>
      oldDelegate.index != index ||
      oldDelegate.isLast != isLast ||
      oldDelegate.screenWidth != screenWidth;
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
