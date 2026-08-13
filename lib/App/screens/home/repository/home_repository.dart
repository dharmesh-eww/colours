class HomeRepository {
  // ── Player Info ────────────────────────────────────────────────────────────
  String getPlayerName() => 'Player';
  int getPlayerLevel() => 24;
  double getLevelProgress() => 0.65; // 65% toward next level

  // ── Stats ──────────────────────────────────────────────────────────────────
  int getStarsCollected() => 58;
  int getTotalStars() => 300;
  int getCoins() => 1250;

  // ── Achievements ───────────────────────────────────────────────────────────
  int getAchievementsUnlocked() => 18;
  int getTotalAchievements() => 50;

  // ── Daily Challenge ────────────────────────────────────────────────────────
  String getDailyChallengeTimeLeft() => '12h 45m left';

  // ── Progress ───────────────────────────────────────────────────────────────
  double getProgressPercent() => 0.24; // 24% complete
  int getLevelsCompleted() => 24;
  int getTotalLevels() => 100;
}
