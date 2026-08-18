import 'package:statekit/statekit.dart';
import '../binding/statistic_screen_binding.dart';

class StatisticScreenController extends StateController<StatisticScreenBinding> {
  int playerLevel = 24;
  double levelProgress = 0.65;
  int starsEarned = 72;
  int maxStars = 300;
  int coins = 1250;

  // Gameplay metrics
  int totalPlayTimeMinutes = 105; // 1h 45m
  int highScore = 14200;
  double winRate = 0.94; // 94%
  int levelsWon = 24;

  // Performance metrics
  int blocksCleared = 1820;
  int maxComboRecord = 5;
  int averageSolveSeconds = 26;
  int totalMovesMade = 480;

}