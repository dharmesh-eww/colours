import 'package:flutter/widgets.dart';
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

  // ── Scroll Management ──────────────────────────────────────────────────────
  final ScrollController scrollController = ScrollController();

  void loadData() {
    starsCollected = _repository.getStarsCollected();
    totalStars = _repository.getTotalStars();
    coins = _repository.getCoins();
    levels = _repository.getLevels();
    update();
  }

  void scrollToActiveLevel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        final activeIndex = levels.indexWhere((l) => l.state == LevelState.current);
        if (activeIndex != -1) {
          // Center the active level: tile height is 120, offset centers it
          final double offset = (activeIndex * 120.0) - 250.0;
          scrollController.jumpTo(
            offset.clamp(0.0, scrollController.position.maxScrollExtent),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
