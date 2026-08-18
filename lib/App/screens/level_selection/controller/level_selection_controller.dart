import 'package:statekit/statekit.dart';
import '../repository/level_selection_repository.dart';
import '../binding/level_selection_binding.dart';

class LevelSelectionController extends StateController<LevelSelectionBinding> {
  final LevelSelectionRepository _repository = LevelSelectionRepository();

  // ── Player Info ────────────────────────────────────────────────────────────
  String playerName = 'Player';
  int playerLevel = 24;
  double levelProgress = 0.65;

  // ── Stats ──────────────────────────────────────────────────────────────────
  int starsCollected = 0;
  int totalStars = 0;
  int coins = 0;

  // ── Levels ─────────────────────────────────────────────────────────────────
  List<LevelData> levels = [];

  void loadData() {
    starsCollected = _repository.getStarsCollected();
    totalStars = _repository.getTotalStars();
    coins = _repository.getCoins();
    levels = _repository.getLevels();
    update();
  }
}
