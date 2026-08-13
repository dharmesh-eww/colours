import 'package:statekit/statekit.dart';
import '../repository/home_repository.dart';
import '../binding/home_binding.dart';

class HomeController extends StateController<HomeBinding> {
  final HomeRepository _repository = HomeRepository();

  // ── Player Info ────────────────────────────────────────────────────────────
  String playerName = '';
  int playerLevel = 0;
  double levelProgress = 0.0;

  // ── Stats ──────────────────────────────────────────────────────────────────
  int starsCollected = 0;
  int totalStars = 0;
  int coins = 0;

  // ── Achievements ───────────────────────────────────────────────────────────
  int achievementsUnlocked = 0;
  int totalAchievements = 0;

  // ── Daily Challenge ────────────────────────────────────────────────────────
  String dailyChallengeTimeLeft = '';

  // ── Progress ───────────────────────────────────────────────────────────────
  double progressPercent = 0.0;
  int levelsCompleted = 0;
  int totalLevels = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void loadData() {
    playerName = _repository.getPlayerName();
    playerLevel = _repository.getPlayerLevel();
    levelProgress = _repository.getLevelProgress();

    starsCollected = _repository.getStarsCollected();
    totalStars = _repository.getTotalStars();
    coins = _repository.getCoins();

    achievementsUnlocked = _repository.getAchievementsUnlocked();
    totalAchievements = _repository.getTotalAchievements();

    dailyChallengeTimeLeft = _repository.getDailyChallengeTimeLeft();

    progressPercent = _repository.getProgressPercent();
    levelsCompleted = _repository.getLevelsCompleted();
    totalLevels = _repository.getTotalLevels();

    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
