import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'puzzle_model.dart';
import 'levels/raw_level_data.dart';

/// A dynamic level-based puzzle generator that mimics the exact layout, colors,
/// and difficulty of the decompiled levels, but dynamically scrambles the board
/// based on random seeds.
class NewPuzzleGenerator {
  NewPuzzleGenerator._internal();
  static final NewPuzzleGenerator instance = NewPuzzleGenerator._internal();
  factory NewPuzzleGenerator() => instance;

  /// Generates a dynamic puzzle for any level number.
  PuzzleData generate(int levelNumber, {int? seed}) {
    final int validLevel = math.max(1, levelNumber);
    final int effectiveSeed = seed ?? _deriveDefaultSeed(validLevel);
    final math.Random random = math.Random(effectiveSeed);

    // Reuse the layout and color palette blueprint from RawLevelData.
    final int refLevelIdx = (validLevel - 1) % RawLevelData.levels.length;
    final String rawStr = RawLevelData.levels[refLevelIdx];
    final List<String> parts = rawStr.trim().split(' ');

    final int logicalCols = int.parse(parts[0]);
    final int logicalRows = int.parse(parts[1]);
    final Color c00 = _hexToColor(parts[2]);
    final Color c01 = _hexToColor(parts[3]);
    final Color c10 = _hexToColor(parts[4]);
    final Color c11 = _hexToColor(parts[5]);

    // Visually, the grid layout on screen is transposed
    final int visualCols = logicalRows;
    final int visualRows = logicalCols;
    final int totalTiles = visualRows * visualCols;

    final List<PuzzleTile> solvedTiles = List<PuzzleTile>.filled(
      totalTiles,
      const PuzzleTile(id: 0, correctIndex: 0, color: Colors.black),
    );

    // We will parse the exact fixed mask from the decompiled level data to maintain identical difficulty.
    final List<bool> fixedMask = List<bool>.filled(totalTiles, false);

    int tileIdx = 0;
    for (int r = 0; r < logicalRows; r++) {
      final double u = (logicalRows - 1) > 0 ? r / (logicalRows - 1) : 0.0;
      final double uInv = 1.0 - u;

      for (int c = 0; c < logicalCols; c++) {
        final double v = (logicalCols - 1) > 0 ? c / (logicalCols - 1) : 0.0;
        final double vInv = 1.0 - v;

        // Bilinear Lerp (RGB interpolation)
        final double topR = (c01.r * v) + (c00.r * vInv);
        final double topG = (c01.g * v) + (c00.g * vInv);
        final double topB = (c01.b * v) + (c00.b * vInv);

        final double bottomR = (c11.r * v) + (c10.r * vInv);
        final double bottomG = (c11.g * v) + (c10.g * vInv);
        final double bottomB = (c11.b * v) + (c10.b * vInv);

        final double cellR = (bottomR * u) + (topR * uInv);
        final double cellG = (bottomG * u) + (topG * uInv);
        final double cellB = (bottomB * u) + (topB * uInv);

        final Color color = Color.fromRGBO(
          (cellR * 255).round().clamp(0, 255),
          (cellG * 255).round().clamp(0, 255),
          (cellB * 255).round().clamp(0, 255),
          1.0,
        );

        final int offset = 6 + tileIdx * 3;
        final bool isFixed = int.parse(parts[offset]) != 0;

        // Map logical coordinates (r, c) to visual grid coordinates
        final int correctIdx = c * visualCols + r;

        solvedTiles[correctIdx] = PuzzleTile(
          id: correctIdx,
          correctIndex: correctIdx,
          color: color,
          isFixed: isFixed,
        );

        fixedMask[correctIdx] = isFixed;
        tileIdx++;
      }
    }

    // Scramble the board dynamically based on the random seed
    final List<PuzzleTile> currentTiles = _scrambleBoard(solvedTiles, random);

    final int fixedCount = solvedTiles.where((t) => t.isFixed).length;
    final int scrambleSteps = math.max(10, (totalTiles - fixedCount) * 2);

    final tier = PuzzleDifficultyTier(
      name: 'Dynamic Level $validLevel',
      gridRows: visualRows,
      gridCols: visualCols,
      scrambleSteps: scrambleSteps,
      fixedTilesCount: fixedCount,
      colorTightness: 0.5,
    );

    return PuzzleData(
      levelNumber: validLevel,
      puzzleId: 'dyn_lvl_${validLevel}_s$effectiveSeed',
      generationVersion: 2,
      seed: effectiveSeed,
      gridRows: visualRows,
      gridCols: visualCols,
      tier: tier,
      tiles: currentTiles,
      solvedTiles: solvedTiles,
      minMoves: math.max(1, (scrambleSteps * 0.6).round()),
      debugMetadata: const {},
    );
  }

  /// Scrambles only the moveable tiles, leaving the fixed tiles locked in their correct solved positions.
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

    // Fisher-Yates shuffle
    for (int i = moveableTiles.length - 1; i > 0; i--) {
      final int j = random.nextInt(i + 1);
      final temp = moveableTiles[i];
      moveableTiles[i] = moveableTiles[j];
      moveableTiles[j] = temp;
    }

    for (int i = 0; i < moveableIndices.length; i++) {
      scrambled[moveableIndices[i]] = moveableTiles[i];
    }

    // Ensure the scrambled state is not already solved
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

  Color _hexToColor(String hex) {
    final String clean = hex.replaceAll('#', '');
    return Color(int.parse('0xFF$clean'));
  }

  int _deriveDefaultSeed(int level) {
    return (level * 10007 + 7919 + 42) & 0x7FFFFFFF;
  }
}
