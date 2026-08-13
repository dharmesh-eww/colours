/// Represents a single level's state in level selection
class LevelData {
  final int number;
  final int starsEarned; // 0, 1, 2, or 3
  final LevelState state;

  const LevelData({
    required this.number,
    required this.starsEarned,
    required this.state,
  });
}

enum LevelState { completed, current, locked }

class LevelSelectionRepository {
  static const int maxLevels = 900;

  int getStarsCollected() => 45;
  int getTotalStars() => maxLevels * 3; // 2700 stars
  int getCoins() => 1250;

  List<LevelData> getLevels() {
    return List.generate(maxLevels, (i) {
      final int levelNum = i + 1;
      if (levelNum <= 15) {
        return LevelData(
          number: levelNum,
          starsEarned: 3,
          state: LevelState.completed,
        );
      } else if (levelNum == 16) {
        return LevelData(
          number: levelNum,
          starsEarned: 0,
          state: LevelState.current,
        );
      } else {
        return LevelData(
          number: levelNum,
          starsEarned: 0,
          state: LevelState.locked,
        );
      }
    });
  }
}