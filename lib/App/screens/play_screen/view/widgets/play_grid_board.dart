import 'package:flutter/material.dart';
import 'package:colours/App/core/puzzle/puzzle_model.dart';
import '../../controller/play_screen_controller.dart';

class PlayGridBoard extends StatelessWidget {
  final PlayScreenController controller;

  const PlayGridBoard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final puzzle = ctrl.puzzle;
    final tiles = ctrl.currentTiles;

    if (puzzle == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: List.generate(puzzle.gridRows, (r) {
          return Expanded(
            child: Row(
              children: List.generate(puzzle.gridCols, (c) {
                final int index = r * puzzle.gridCols + c;
                final bool isSelected = ctrl.selectedTileIndex == index;
                final PuzzleTile tile = tiles[index];

                return Expanded(
                  child: _DraggableTileCell(
                    index: index,
                    tile: tile,
                    isSelected: isSelected,
                    controller: ctrl,
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class _DraggableTileCell extends StatelessWidget {
  final int index;
  final PuzzleTile tile;
  final bool isSelected;
  final PlayScreenController controller;

  const _DraggableTileCell({
    required this.index,
    required this.tile,
    required this.isSelected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cellWidth = constraints.maxWidth;
        final double cellHeight = constraints.maxHeight;

        return DragTarget<int>(
          onWillAcceptWithDetails: (details) {
            final int fromIndex = details.data;
            return fromIndex != index && !tile.isFixed;
          },
          onAcceptWithDetails: (details) {
            final int fromIndex = details.data;
            controller.swapTiles(fromIndex, index);
          },
          builder: (context, candidateData, rejectedData) {
            final bool isHovered = candidateData.isNotEmpty;

            final Widget baseTileVisual = _TileVisualContainer(
              tile: tile,
              isSelected: isSelected,
              isHovered: isHovered,
            );

            if (tile.isFixed) {
              return baseTileVisual;
            }

            return LongPressDraggable<int>(
              data: index,
              delay: const Duration(milliseconds: 100),
              feedback: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: cellWidth,
                  height: cellHeight,
                  child: _TileVisualContainer(
                    tile: tile,
                    isSelected: true,
                    isHovered: false,
                    isDraggingFeedback: true,
                  ),
                ),
              ),
              childWhenDragging: Opacity(opacity: 0.25, child: baseTileVisual),
              child: GestureDetector(
                onTap: () => controller.selectTile(index),
                child: baseTileVisual,
              ),
            );
          },
        );
      },
    );
  }
}

class _TileVisualContainer extends StatelessWidget {
  final PuzzleTile tile;
  final bool isSelected;
  final bool isHovered;
  final bool isDraggingFeedback;

  const _TileVisualContainer({
    required this.tile,
    required this.isSelected,
    required this.isHovered,
    this.isDraggingFeedback = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color tileColor = tile.color;
    final bool highlighted = isSelected || isHovered || isDraggingFeedback;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.zero,
        border: highlighted ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: [
          if (isDraggingFeedback)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          if (highlighted)
            BoxShadow(color: Colors.white.withValues(alpha: 0.6), blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: tile.isFixed
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1),
                ),
              ),
            )
          : null,
    );
  }
}
