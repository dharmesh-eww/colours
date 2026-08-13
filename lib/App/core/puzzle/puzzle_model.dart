import 'package:flutter/material.dart';

/// State of a single color tile in the puzzle.
class PuzzleTile {
  final int id;
  final int correctIndex;
  final Color color;
  final bool isFixed;

  const PuzzleTile({
    required this.id,
    required this.correctIndex,
    required this.color,
    this.isFixed = false,
  });

  PuzzleTile copyWith({
    int? id,
    int? correctIndex,
    Color? color,
    bool? isFixed,
  }) {
    return PuzzleTile(
      id: id ?? this.id,
      correctIndex: correctIndex ?? this.correctIndex,
      color: color ?? this.color,
      isFixed: isFixed ?? this.isFixed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleTile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          correctIndex == other.correctIndex &&
          color == other.color &&
          isFixed == other.isFixed;

  @override
  int get hashCode => Object.hash(id, correctIndex, color, isFixed);
}

/// Difficulty tier configuration for a puzzle.
class PuzzleDifficultyTier {
  final String name;
  final int gridRows;
  final int gridCols;
  final int scrambleSteps;
  final int fixedTilesCount;
  final double colorTightness;

  const PuzzleDifficultyTier({
    required this.name,
    required this.gridRows,
    required this.gridCols,
    required this.scrambleSteps,
    required this.fixedTilesCount,
    required this.colorTightness,
  });
}

/// Immutable data container representing a complete generated puzzle.
class PuzzleData {
  final int levelNumber;
  final String puzzleId;
  final int generationVersion;
  final int seed;
  final int gridRows;
  final int gridCols;
  final PuzzleDifficultyTier tier;
  final List<PuzzleTile> tiles;
  final List<PuzzleTile> solvedTiles;
  final int minMoves;
  final Map<String, dynamic> debugMetadata;

  const PuzzleData({
    required this.levelNumber,
    required this.puzzleId,
    required this.generationVersion,
    required this.seed,
    required this.gridRows,
    required this.gridCols,
    required this.tier,
    required this.tiles,
    required this.solvedTiles,
    required this.minMoves,
    required this.debugMetadata,
  });

  /// Total number of tiles in the grid.
  int get totalTiles => gridRows * gridCols;

  /// Checks if the provided tile layout matches the target solved layout.
  bool isSolved(List<PuzzleTile> currentTiles) {
    if (currentTiles.length != solvedTiles.length) return false;
    for (int i = 0; i < currentTiles.length; i++) {
      if (currentTiles[i].correctIndex != i) {
        return false;
      }
    }
    return true;
  }

  /// Calculates the number of tiles that are currently not in their correct solved position.
  int countMisplacedTiles(List<PuzzleTile> currentTiles) {
    int misplaced = 0;
    for (int i = 0; i < currentTiles.length; i++) {
      if (currentTiles[i].correctIndex != i) {
        misplaced++;
      }
    }
    return misplaced;
  }
}
