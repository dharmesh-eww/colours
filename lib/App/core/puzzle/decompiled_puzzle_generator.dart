import 'package:flutter/material.dart';
import 'puzzle_model.dart';
import 'levels/raw_level_data.dart';

/// Puzzle generator that decodes and builds puzzles from decompiled APK level strings.
class DecompiledPuzzleGenerator {
  DecompiledPuzzleGenerator._internal();
  static final DecompiledPuzzleGenerator instance = DecompiledPuzzleGenerator._internal();
  factory DecompiledPuzzleGenerator() => instance;

  /// Decodes a predefined level string (levels 1-810) into a complete PuzzleData object.
  PuzzleData generate(int levelNumber) {
    final int validLevel = levelNumber.clamp(1, RawLevelData.levels.length);
    final String rawStr = RawLevelData.levels[validLevel - 1];
    final List<String> parts = rawStr.trim().split(' ');

    // parts[0] is logical columns, parts[1] is logical rows in the APK level string
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
    final List<PuzzleTile> currentTiles = List<PuzzleTile>.filled(
      totalTiles,
      const PuzzleTile(id: 0, correctIndex: 0, color: Colors.black),
    );

    int tileIdx = 0;
    for (int r = 0; r < logicalRows; r++) {
      final double u = (logicalRows - 1) > 0 ? r / (logicalRows - 1) : 0.0;
      final double uInv = 1.0 - u;

      for (int c = 0; c < logicalCols; c++) {
        final double v = (logicalCols - 1) > 0 ? c / (logicalCols - 1) : 0.0;
        final double vInv = 1.0 - v;

        // Exact Bilinear Lerp (decompiled t90.j logic)
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
        final int displayCol = int.parse(parts[offset + 1]);
        final int displayRow = int.parse(parts[offset + 2]);

        // Map logical coordinates (r, c) to visual grid coordinates (solvedRow = c, solvedCol = r)
        final int correctIdx = c * visualCols + r;
        final int displayIdx = displayRow * visualCols + displayCol;

        final tile = PuzzleTile(
          id: correctIdx,
          correctIndex: correctIdx,
          color: color,
          isFixed: isFixed,
        );

        solvedTiles[correctIdx] = tile;
        currentTiles[displayIdx] = tile;

        tileIdx++;
      }
    }

    final tier = PuzzleDifficultyTier(
      name: 'APK Level $validLevel',
      gridRows: visualRows,
      gridCols: visualCols,
      scrambleSteps: 20,
      fixedTilesCount: solvedTiles.where((t) => t.isFixed).length,
      colorTightness: 0.5,
    );

    return PuzzleData(
      levelNumber: validLevel,
      puzzleId: 'apk_lvl_$validLevel',
      generationVersion: 1,
      seed: validLevel,
      gridRows: visualRows,
      gridCols: visualCols,
      tier: tier,
      tiles: currentTiles,
      solvedTiles: solvedTiles,
      minMoves: 0,
      debugMetadata: const {},
    );
  }

  Color _hexToColor(String hex) {
    final String clean = hex.replaceAll('#', '');
    return Color(int.parse('0xFF$clean'));
  }
}
