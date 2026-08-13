import 'package:statekit/statekit.dart';
import 'package:colours/App/core/puzzle/puzzle_model.dart';
import '../repository/play_screen_repository.dart';
import '../binding/play_screen_binding.dart';

class PlayScreenController extends StateController<PlayScreenBinding> {
  final PlayScreenRepository _repository = PlayScreenRepository();

  // ── Current Puzzle Configuration ──────────────────────────────────────────
  PuzzleData? puzzle;
  int currentLevel = 1;

  // ── Active Gameplay State ──────────────────────────────────────────────────
  List<PuzzleTile> currentTiles = [];
  int? selectedTileIndex;
  int moves = 0;
  String time = '01:24';
  String bestTime = '01:10';
  bool isCompleted = false;
  bool hasShownCompletionDialog = false;

  // ── Action Counts ─────────────────────────────────────────────────────────
  int hintCount = 3;
  int undoCount = 5;
  int shuffleCount = 1;

  // ── Previous Move History for Undo ─────────────────────────────────────────
  final List<List<PuzzleTile>> _history = [];

  @override
  void onInit() {
    super.onInit();
    if (arguments is int) {
      loadLevel(arguments as int);
    }
  }

  void loadLevel(int levelNumber, {bool shouldNotify = true}) {
    currentLevel = levelNumber;
    puzzle = _repository.getPuzzleForLevel(levelNumber);
    currentTiles = List<PuzzleTile>.from(puzzle!.tiles);
    selectedTileIndex = null;
    moves = 0;
    isCompleted = false;
    hasShownCompletionDialog = false;
    _history.clear();
    if (shouldNotify) {
      update();
    }
  }

  void loadNextLevel() {
    if (currentLevel < 900) {
      loadLevel(currentLevel + 1);
    }
  }

  /// Swaps two tiles at [fromIndex] and [toIndex] (used by Drag & Drop and Tap & Swap).
  void swapTiles(int fromIndex, int toIndex) {
    if (puzzle == null) return;
    if (fromIndex == toIndex) return;
    if (fromIndex < 0 || fromIndex >= currentTiles.length) return;
    if (toIndex < 0 || toIndex >= currentTiles.length) return;
    if (currentTiles[fromIndex].isFixed || currentTiles[toIndex].isFixed) return;

    // Record state for Undo
    _history.add(List<PuzzleTile>.from(currentTiles));

    // Perform swap
    final temp = currentTiles[fromIndex];
    currentTiles[fromIndex] = currentTiles[toIndex];
    currentTiles[toIndex] = temp;

    selectedTileIndex = null;
    moves++;

    // Check if puzzle is completed
    if (puzzle!.isSolved(currentTiles)) {
      onPuzzleCompleted();
    }
    update();
  }

  /// Interactive tile selection logic (Tap & Swap).
  void selectTile(int index) {
    if (index < 0 || index >= currentTiles.length) return;

    final tile = currentTiles[index];
    if (tile.isFixed) return; // Fixed tiles cannot be selected or moved

    if (selectedTileIndex == null) {
      selectedTileIndex = index;
      update();
    } else if (selectedTileIndex == index) {
      selectedTileIndex = null;
      update();
    } else {
      swapTiles(selectedTileIndex!, index);
    }
  }

  void onUndo() {
    if (_history.isNotEmpty && undoCount > 0 && !isCompleted) {
      undoCount--;
      currentTiles = _history.removeLast();
      selectedTileIndex = null;
      update();
    }
  }

  void onHint() {
    if (hintCount > 0 && !isCompleted) {
      hintCount--;
      // Find the first out-of-place tile and highlight its target
      for (int i = 0; i < currentTiles.length; i++) {
        if (!currentTiles[i].isFixed && currentTiles[i].correctIndex != i) {
          selectedTileIndex = i;
          break;
        }
      }
      update();
    }
  }

  void onRestart() {
    loadLevel(currentLevel);
  }

  void onShuffle() {
    if (shuffleCount > 0 && !isCompleted) {
      shuffleCount--;
      // Perform a fresh scramble of non-fixed tiles
      loadLevel(currentLevel);
    }
  }

  void onPuzzleCompleted() {
    isCompleted = true;
    binding?.puzzleComplete();
  }
}
