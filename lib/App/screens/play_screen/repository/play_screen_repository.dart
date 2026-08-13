import 'package:colours/App/core/puzzle/new_puzzle_generator.dart';
import 'package:colours/App/core/puzzle/puzzle_model.dart';

class PlayScreenRepository {
  /// Fetches puzzle configuration for the given level number.
  /// Generates dynamic decompiled-style layouts using NewPuzzleGenerator.
  PuzzleData getPuzzleForLevel(int levelNumber) {
    return NewPuzzleGenerator.instance.generate(levelNumber);
  }
}
