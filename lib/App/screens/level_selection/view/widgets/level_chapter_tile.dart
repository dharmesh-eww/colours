import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/routes/app_routes.dart';
import '../../repository/level_selection_repository.dart';

class LevelGrid extends StatelessWidget {
  final List<LevelData> levels;

  const LevelGrid({super.key, required this.levels});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: levels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return LevelCell(level: levels[index]);
      },
    );
  }
}

class LevelCell extends StatelessWidget {
  final LevelData level;
  const LevelCell({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final colors = _colorsForState(level.state);

    return GestureDetector(
      onTap: () {
        // if (level.state != LevelState.locked) {
        Navigator.pushNamed(context, Routes.playScreen, arguments: level.number);
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors.gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: colors.shadow, blurRadius: 0, offset: const Offset(0, 4)),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: colors.border, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Number or lock
            if (level.state == LevelState.locked)
              const Icon(Icons.lock_rounded, color: Colors.white70, size: 20)
            else
              Text(
                '${level.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  shadows: [Shadow(color: Color(0x66000000), blurRadius: 4, offset: Offset(0, 2))],
                ),
              ),
            const SizedBox(height: 4),
            // Stars row
            _StarsRow(earned: level.starsEarned, state: level.state),
          ],
        ),
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
          gradient: [Color(0xFF7B52C8), Color(0xFF5A3AA0)],
          shadow: Color(0xFF3A2070),
          border: Color(0xFF9B72E8),
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (_) => const Icon(Icons.star_rounded, color: Color(0x55FFFFFF), size: 10),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final isFilled = i < earned;
        return Icon(
          Icons.star_rounded,
          color: isFilled ? AppColors.accentGold : const Color(0x55FFFFFF),
          size: 11,
        );
      }),
    );
  }
}
