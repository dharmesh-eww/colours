import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'puzzle_model.dart';

/// Level-wise Gradient Puzzle Generator.
///
/// Features level-based difficulty progression:
/// - Level 1: Top-to-Bottom 1D Vertical Gradient strip (1x5).
/// - Level 2: Left-to-Right 1D Horizontal Gradient strip (5x1).
/// - Level 3: Top-to-Bottom 2D Row Gradient (3x3).
/// - Level 4: Left-to-Right 2D Column Gradient (3x3).
/// - Level 5: Diagonal Gradient from Top-Left to Bottom-Right (3x3).
/// - Level 6-15: 3x3 / 4x4 Bilinear 4-Corner Gradient (Easy 2D).
/// - Level 16-30: 4x4 Bilinear 4-Corner Gradient with Center Anchor (Medium 2D).
/// - Level 31-50: 5x5 Bilinear 4-Corner Gradient (Hard 2D).
/// - Level 51+: 6x6 / 7x7 Multi-Corner Bilinear Gradient (Master 2D).
class PuzzleGenerator {
  PuzzleGenerator._internal();
  static final PuzzleGenerator instance = PuzzleGenerator._internal();
  factory PuzzleGenerator() => instance;

  static const int currentVersion = 2;

  /// Curated 2-color pairs for 1D gradients (Levels 1-5)
  static const List<List<Color>> _dualColorThemes = [
    [Color(0xFFFF5252), Color(0xFFFFEB3B)], // Red -> Yellow
    [Color(0xFF00E676), Color(0xFF00B0FF)], // Green -> Cyan Blue
    [Color(0xFFAA00FF), Color(0xFFFF4081)], // Purple -> Pink
    [Color(0xFFFF6D00), Color(0xFFFFD600)], // Orange -> Bright Yellow
    [Color(0xFF3D5AFE), Color(0xFF00E5FF)], // Deep Blue -> Light Blue
    [Color(0xFFE91E63), Color(0xFF9C27B0)], // Pink -> Deep Purple
    [Color(0xFF1DE9B6), Color(0xFFAEEA00)], // Teal -> Lime Green
    [Color(0xFFFF9100), Color(0xFFFF3D00)], // Amber -> Deep Orange
  ];

  /// Curated 4-corner quads for 2D Bilinear lerp (Levels 6+)
  static const List<_QuadColors> _apkPalettes = [
    _QuadColors(Color(0xFF5D5F84), Color(0xFF799CAF), Color(0xFF9E7E82), Color(0xFFEBDD9E)),
    _QuadColors(Color(0xFF78B52B), Color(0xFFCBFF4B), Color(0xFF45423D), Color(0xFFDD6F03)),
    _QuadColors(Color(0xFFD94B61), Color(0xFF4F4B5A), Color(0xFFF1F1C8), Color(0xFF66A9A5)),
    _QuadColors(Color(0xFFE8E595), Color(0xFFD0A825), Color(0xFF40627C), Color(0xFF26393D)),
    _QuadColors(Color(0xFF5D0859), Color(0xFFE678D8), Color(0xFF40A4A2), Color(0xFFEECC3A)),
    _QuadColors(Color(0xFFDFD24A), Color(0xFFE15C3A), Color(0xFF4A7482), Color(0xFF543030)),
    _QuadColors(Color(0xFFF2D540), Color(0xFFF0F0CF), Color(0xFFDF4949), Color(0xFF20A28E)),
    _QuadColors(Color(0xFFF29471), Color(0xFFFCDFA6), Color(0xFF3D7585), Color(0xFF36B898)),
    _QuadColors(Color(0xFFE53481), Color(0xFFFCB215), Color(0xFF8151A1), Color(0xFF25B0E6)),
    _QuadColors(Color(0xFF003B59), Color(0xFF00996D), Color(0xFFFF930E), Color(0xFFF2E926)),
    _QuadColors(Color(0xFFFFD23E), Color(0xFFFCF769), Color(0xFF6163D3), Color(0xFF6DB7CA)),
    _QuadColors(Color(0xFF0C3E55), Color(0xFF5EE8E8), Color(0xFFE68A59), Color(0xFFFBE201)),
    _QuadColors(Color(0xFFE65D39), Color(0xFFEBC95E), Color(0xFF765783), Color(0xFF4DAF7C)),
    _QuadColors(Color(0xFF00A672), Color(0xFFFFE823), Color(0xFF5F1470), Color(0xFFC71A37)),
    _QuadColors(Color(0xFFDDEDF4), Color(0xFF7FCCC3), Color(0xFFEF4445), Color(0xFF004A61)),
    _QuadColors(Color(0xFF46B39D), Color(0xFF324D5C), Color(0xFFF0CA4D), Color(0xFFDE5B49)),
    _QuadColors(Color(0xFF72D6C9), Color(0xFFFFC785), Color(0xFF7189BF), Color(0xFFDF7599)),
    _QuadColors(Color(0xFFFED832), Color(0xFF82E3E1), Color(0xFFEC3978), Color(0xFF634396)),
    _QuadColors(Color(0xFFCA3995), Color(0xFFF58220), Color(0xFF61BC46), Color(0xFFFFDF05)),
    _QuadColors(Color(0xFFE97778), Color(0xFFFFD57E), Color(0xFF7998C9), Color(0xFF89C7B6)),
  ];

  /// Generate puzzle with level-specific gradient logic.
  PuzzleData generate(int levelNumber, {int? seed, int? generationVersion}) {
    final int validLevel = math.max(1, levelNumber);
    final int version = generationVersion ?? currentVersion;
    final int effectiveSeed = seed ?? _deriveDefaultSeed(validLevel, version);
    final math.Random random = math.Random(effectiveSeed);

    final PuzzleDifficultyTier tier = _determineDifficulty(validLevel);
    final int rows = tier.gridRows.clamp(3, 10);
    final int cols = tier.gridCols.clamp(3, 10);
    final int totalTiles = rows * cols;

    List<Color> solvedColors;
    List<bool> fixedMask;

    if (validLevel == 1) {
      // Level 1: Top-to-Bottom 1D Vertical Strip (1x5)
      final List<Color> theme = _dualColorThemes[(validLevel - 1) % _dualColorThemes.length];
      solvedColors = _generateVerticalLinearGradient(rows, cols, theme[0], theme[1]);
      fixedMask = _generateLinearFixedMask(totalTiles, [0, totalTiles - 1]);
    } else if (validLevel == 2) {
      // Level 2: Left-to-Right 1D Horizontal Strip (5x1)
      final List<Color> theme = _dualColorThemes[(validLevel - 1) % _dualColorThemes.length];
      solvedColors = _generateHorizontalLinearGradient(rows, cols, theme[0], theme[1]);
      fixedMask = _generateLinearFixedMask(totalTiles, [0, totalTiles - 1]);
    } else if (validLevel == 3) {
      // Level 3: Top-to-Bottom 2D Row Gradient (3x3)
      final List<Color> theme = _dualColorThemes[(validLevel - 1) % _dualColorThemes.length];
      solvedColors = _generateVerticalLinearGradient(rows, cols, theme[0], theme[1]);
      fixedMask = _generateLinearFixedMask(totalTiles, [0, totalTiles - 1]);
    } else if (validLevel == 4) {
      // Level 4: Left-to-Right 2D Column Gradient (3x3)
      final List<Color> theme = _dualColorThemes[(validLevel - 1) % _dualColorThemes.length];
      solvedColors = _generateHorizontalLinearGradient(rows, cols, theme[0], theme[1]);
      fixedMask = _generateLinearFixedMask(totalTiles, [0, cols - 1]);
    } else if (validLevel == 5) {
      // Level 5: Diagonal Gradient Top-Left to Bottom-Right (3x3)
      final List<Color> theme = _dualColorThemes[(validLevel - 1) % _dualColorThemes.length];
      solvedColors = _generateDiagonalGradient(rows, cols, theme[0], theme[1]);
      fixedMask = _generateLinearFixedMask(totalTiles, [0, totalTiles - 1]);
    } else {
      // Level 6+: 2D Bilinear 4-Corner Interpolation Matrix
      final _QuadColors quad = _selectQuadColors(validLevel, random);
      solvedColors = _generateBilinearGridColors(rows, cols, quad);
      fixedMask = _generateFixedMask(rows, cols, tier.fixedTilesCount, random);
    }

    final List<PuzzleTile> solvedTiles = List.generate(totalTiles, (index) {
      return PuzzleTile(
        id: index,
        correctIndex: index,
        color: solvedColors[index],
        isFixed: fixedMask[index],
      );
    });

    final List<PuzzleTile> scrambledTiles = _scrambleBoard(solvedTiles, random);

    final String puzzleId = 'lvl_${validLevel}_s${effectiveSeed}_v$version';
    final int estimatedMinMoves = math.max(1, (tier.scrambleSteps * 0.6).round());

    return PuzzleData(
      levelNumber: validLevel,
      puzzleId: puzzleId,
      generationVersion: version,
      seed: effectiveSeed,
      gridRows: rows,
      gridCols: cols,
      tier: tier,
      tiles: scrambledTiles,
      solvedTiles: solvedTiles,
      minMoves: estimatedMinMoves,
      debugMetadata: {
        'levelNumber': validLevel,
        'puzzleId': puzzleId,
        'generationVersion': version,
        'seed': effectiveSeed,
        'difficultyTier': tier.name,
        'gridDimensions': '${rows}x$cols',
        'totalTiles': totalTiles,
        'fixedTilesCount': solvedTiles.where((t) => t.isFixed).length,
        'isSolvable': true,
      },
    );
  }

  // ── Difficulty Progression ───────────────────────────────────────────────

  PuzzleDifficultyTier _determineDifficulty(int level) {
    if (level == 1) {
      return const PuzzleDifficultyTier(
        name: 'Tutorial: Vertical Gradient',
        gridRows: 3,
        gridCols: 3,
        scrambleSteps: 4,
        fixedTilesCount: 2,
        colorTightness: 0.10,
      );
    } else if (level == 2) {
      return const PuzzleDifficultyTier(
        name: 'Tutorial: Horizontal Gradient',
        gridRows: 3,
        gridCols: 3,
        scrambleSteps: 4,
        fixedTilesCount: 2,
        colorTightness: 0.10,
      );
    } else if (level == 3) {
      return const PuzzleDifficultyTier(
        name: 'Easy: Top to Bottom Gradient',
        gridRows: 3,
        gridCols: 3,
        scrambleSteps: 6,
        fixedTilesCount: 2,
        colorTightness: 0.15,
      );
    } else if (level == 4) {
      return const PuzzleDifficultyTier(
        name: 'Easy: Left to Right Gradient',
        gridRows: 3,
        gridCols: 3,
        scrambleSteps: 6,
        fixedTilesCount: 2,
        colorTightness: 0.15,
      );
    } else if (level == 5) {
      return const PuzzleDifficultyTier(
        name: 'Easy: Diagonal Gradient',
        gridRows: 3,
        gridCols: 3,
        scrambleSteps: 8,
        fixedTilesCount: 2,
        colorTightness: 0.20,
      );
    } else if (level <= 15) {
      return const PuzzleDifficultyTier(
        name: 'Medium: 4x4 Gradient',
        gridRows: 4,
        gridCols: 4,
        scrambleSteps: 14,
        fixedTilesCount: 4,
        colorTightness: 0.30,
      );
    } else if (level <= 30) {
      return const PuzzleDifficultyTier(
        name: 'Hard: 5x5 Gradient',
        gridRows: 5,
        gridCols: 5,
        scrambleSteps: 22,
        fixedTilesCount: 5,
        colorTightness: 0.45,
      );
    } else if (level <= 60) {
      return const PuzzleDifficultyTier(
        name: 'Expert: 6x6 Gradient',
        gridRows: 6,
        gridCols: 6,
        scrambleSteps: 35,
        fixedTilesCount: 4,
        colorTightness: 0.60,
      );
    } else if (level <= 100) {
      return const PuzzleDifficultyTier(
        name: 'Master: 7x7 Gradient',
        gridRows: 7,
        gridCols: 7,
        scrambleSteps: 50,
        fixedTilesCount: 4,
        colorTightness: 0.70,
      );
    } else if (level <= 150) {
      return const PuzzleDifficultyTier(
        name: 'Grandmaster: 8x8 Gradient',
        gridRows: 8,
        gridCols: 8,
        scrambleSteps: 70,
        fixedTilesCount: 4,
        colorTightness: 0.80,
      );
    } else if (level <= 200) {
      return const PuzzleDifficultyTier(
        name: 'Legend: 9x9 Gradient',
        gridRows: 9,
        gridCols: 9,
        scrambleSteps: 90,
        fixedTilesCount: 4,
        colorTightness: 0.85,
      );
    } else {
      final int extraLevels = level - 200;
      final int dimension = math.min(10, 9 + (extraLevels ~/ 50));
      final int scramble = math.min(150, 100 + extraLevels);

      return PuzzleDifficultyTier(
        name: 'Supreme: ${dimension}x$dimension (Level $level)',
        gridRows: dimension,
        gridCols: dimension,
        scrambleSteps: scramble,
        fixedTilesCount: 4,
        colorTightness: 0.90,
      );
    }
  }

  // ── Gradient Generators ──────────────────────────────────────────────────

  /// Top-to-Bottom Vertical-dominant Gradient where every cell (r, c) is unique.
  List<Color> _generateVerticalLinearGradient(int rows, int cols, Color topColor, Color bottomColor) {
    final List<Color> grid = List<Color>.filled(rows * cols, Colors.black);
    final double maxRow = (rows - 1).toDouble();
    final double maxCol = (cols - 1).toDouble();

    final HSLColor topHsl = HSLColor.fromColor(topColor);
    final HSLColor bottomHsl = HSLColor.fromColor(bottomColor);

    final Color c00 = topColor;
    final Color c01 = topHsl.withLightness((topHsl.lightness * 0.88).clamp(0.1, 0.9)).toColor();
    final Color c10 = bottomColor;
    final Color c11 = bottomHsl.withLightness((bottomHsl.lightness * 0.88).clamp(0.1, 0.9)).toColor();

    for (int r = 0; r < rows; r++) {
      final double u = maxRow > 0 ? r / maxRow : 0.0;
      for (int c = 0; c < cols; c++) {
        final double v = maxCol > 0 ? c / maxCol : 0.0;
        final Color rowStart = Color.lerp(c00, c10, u)!;
        final Color rowEnd = Color.lerp(c01, c11, u)!;
        grid[r * cols + c] = Color.lerp(rowStart, rowEnd, v)!;
      }
    }
    return grid;
  }

  /// Left-to-Right Horizontal-dominant Gradient where every cell (r, c) is unique.
  List<Color> _generateHorizontalLinearGradient(int rows, int cols, Color leftColor, Color rightColor) {
    final List<Color> grid = List<Color>.filled(rows * cols, Colors.black);
    final double maxRow = (rows - 1).toDouble();
    final double maxCol = (cols - 1).toDouble();

    final HSLColor leftHsl = HSLColor.fromColor(leftColor);
    final HSLColor rightHsl = HSLColor.fromColor(rightColor);

    final Color c00 = leftColor;
    final Color c01 = rightColor;
    final Color c10 = leftHsl.withLightness((leftHsl.lightness * 0.88).clamp(0.1, 0.9)).toColor();
    final Color c11 = rightHsl.withLightness((rightHsl.lightness * 0.88).clamp(0.1, 0.9)).toColor();

    for (int r = 0; r < rows; r++) {
      final double u = maxRow > 0 ? r / maxRow : 0.0;
      for (int c = 0; c < cols; c++) {
        final double v = maxCol > 0 ? c / maxCol : 0.0;
        final Color rowStart = Color.lerp(c00, c10, u)!;
        final Color rowEnd = Color.lerp(c01, c11, u)!;
        grid[r * cols + c] = Color.lerp(rowStart, rowEnd, v)!;
      }
    }
    return grid;
  }

  /// Diagonal-dominant Gradient where every cell (r, c) is unique.
  List<Color> _generateDiagonalGradient(int rows, int cols, Color startColor, Color endColor) {
    final List<Color> grid = List<Color>.filled(rows * cols, Colors.black);
    final double maxRow = (rows - 1).toDouble();
    final double maxCol = (cols - 1).toDouble();

    final HSLColor startHsl = HSLColor.fromColor(startColor);
    final HSLColor endHsl = HSLColor.fromColor(endColor);

    final Color c00 = startColor;
    final Color c01 = startHsl.withHue((startHsl.hue + 30.0) % 360.0).toColor();
    final Color c10 = endHsl.withHue((endHsl.hue - 30.0 + 360.0) % 360.0).toColor();
    final Color c11 = endColor;

    for (int r = 0; r < rows; r++) {
      final double u = maxRow > 0 ? r / maxRow : 0.0;
      for (int c = 0; c < cols; c++) {
        final double v = maxCol > 0 ? c / maxCol : 0.0;
        final Color rowStart = Color.lerp(c00, c10, u)!;
        final Color rowEnd = Color.lerp(c01, c11, u)!;
        grid[r * cols + c] = Color.lerp(rowStart, rowEnd, v)!;
      }
    }
    return grid;
  }

  /// 2D Bilinear RGB Interpolation (from 4 corner colors)
  List<Color> _generateBilinearGridColors(int rows, int cols, _QuadColors quad) {
    final List<Color> grid = List<Color>.filled(rows * cols, Colors.black);
    final double maxCol = (cols - 1).toDouble();
    final double maxRow = (rows - 1).toDouble();

    for (int r = 0; r < rows; r++) {
      final double u = maxRow > 0 ? r / maxRow : 0.0;
      final double uInv = 1.0 - u;

      for (int c = 0; c < cols; c++) {
        final double v = maxCol > 0 ? c / maxCol : 0.0;
        final double vInv = 1.0 - v;

        final double topR = (quad.c01.r * v) + (quad.c00.r * vInv);
        final double topG = (quad.c01.g * v) + (quad.c00.g * vInv);
        final double topB = (quad.c01.b * v) + (quad.c00.b * vInv);

        final double bottomR = (quad.c11.r * v) + (quad.c10.r * vInv);
        final double bottomG = (quad.c11.g * v) + (quad.c10.g * vInv);
        final double bottomB = (quad.c11.b * v) + (quad.c10.b * vInv);

        final double cellR = (bottomR * u) + (topR * uInv);
        final double cellG = (bottomG * u) + (topG * uInv);
        final double cellB = (bottomB * u) + (topB * uInv);

        final int finalR = (cellR * 255).round().clamp(0, 255);
        final int finalG = (cellG * 255).round().clamp(0, 255);
        final int finalB = (cellB * 255).round().clamp(0, 255);

        grid[r * cols + c] = Color.fromRGBO(finalR, finalG, finalB, 1.0);
      }
    }
    return grid;
  }

  // ── Fixed Anchor Masks ───────────────────────────────────────────────────

  List<bool> _generateLinearFixedMask(int totalTiles, List<int> fixedIndices) {
    final List<bool> mask = List<bool>.filled(totalTiles, false);
    for (final idx in fixedIndices) {
      if (idx >= 0 && idx < totalTiles) {
        mask[idx] = true;
      }
    }
    return mask;
  }

  List<bool> _generateFixedMask(int rows, int cols, int targetFixedCount, math.Random random) {
    final int total = rows * cols;
    final List<bool> mask = List<bool>.filled(total, false);

    final int topLeft = 0;
    final int topRight = cols - 1;
    final int bottomLeft = (rows - 1) * cols;
    final int bottomRight = total - 1;
    final int centerIndex = ((rows ~/ 2) * cols) + (cols ~/ 2);

    final List<int> candidates = [topLeft, topRight, bottomLeft, bottomRight, centerIndex];

    if (rows >= 4 && cols >= 4) {
      candidates.add(cols ~/ 2);
      candidates.add((rows - 1) * cols + (cols ~/ 2));
    }

    candidates.shuffle(random);

    int added = 0;
    for (final idx in candidates) {
      if (added >= targetFixedCount) break;
      if (!mask[idx]) {
        mask[idx] = true;
        added++;
      }
    }

    return mask;
  }

  // ── Board Scrambler ──────────────────────────────────────────────────────

  List<PuzzleTile> _scrambleBoard(List<PuzzleTile> solvedTiles, math.Random random) {
    final List<PuzzleTile> scrambled = List<PuzzleTile>.from(solvedTiles);

    final List<int> moveableIndices = [];
    for (int i = 0; i < scrambled.length; i++) {
      if (!scrambled[i].isFixed) {
        moveableIndices.add(i);
      }
    }

    if (moveableIndices.length < 2) {
      return scrambled;
    }

    final List<PuzzleTile> moveableTiles = moveableIndices.map((i) => solvedTiles[i]).toList();

    for (int i = moveableTiles.length - 1; i > 0; i--) {
      final int j = random.nextInt(i + 1);
      final temp = moveableTiles[i];
      moveableTiles[i] = moveableTiles[j];
      moveableTiles[j] = temp;
    }

    for (int i = 0; i < moveableIndices.length; i++) {
      scrambled[moveableIndices[i]] = moveableTiles[i];
    }

    bool isIdentical = true;
    for (int i = 0; i < scrambled.length; i++) {
      if (scrambled[i].id != solvedTiles[i].id) {
        isIdentical = false;
        break;
      }
    }

    if (isIdentical && moveableIndices.length >= 2) {
      final int posA = moveableIndices[0];
      final int posB = moveableIndices[1];
      final temp = scrambled[posA];
      scrambled[posA] = scrambled[posB];
      scrambled[posB] = temp;
    }

    return scrambled;
  }

  _QuadColors _selectQuadColors(int level, math.Random random) {
    if (level <= _apkPalettes.length) {
      return _apkPalettes[level - 1];
    } else if (random.nextDouble() < 0.75) {
      return _apkPalettes[random.nextInt(_apkPalettes.length)];
    } else {
      final double baseHue = random.nextDouble() * 360.0;
      final double hueShiftX = 40.0 + random.nextDouble() * 50.0;
      final double hueShiftY = 50.0 + random.nextDouble() * 60.0;

      final Color c00 = HSLColor.fromAHSL(1.0, baseHue, 0.85, 0.55).toColor();
      final Color c01 = HSLColor.fromAHSL(1.0, (baseHue + hueShiftX) % 360.0, 0.80, 0.50).toColor();
      final Color c10 = HSLColor.fromAHSL(1.0, (baseHue + hueShiftY) % 360.0, 0.75, 0.45).toColor();
      final Color c11 = HSLColor.fromAHSL(1.0, (baseHue + hueShiftX + hueShiftY) % 360.0, 0.70, 0.40).toColor();

      return _QuadColors(c00, c01, c10, c11);
    }
  }

  int _deriveDefaultSeed(int level, int version) {
    return (level * 10007 + version * 7919 + 42) & 0x7FFFFFFF;
  }
}

class _QuadColors {
  final Color c00;
  final Color c01;
  final Color c10;
  final Color c11;

  const _QuadColors(this.c00, this.c01, this.c10, this.c11);
}
