import 'package:flutter/material.dart';

class HomeGameLogo extends StatelessWidget {
  const HomeGameLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── "BLOCK" text ─────────────────────────────────────────────
        _buildBlockText(),
        const SizedBox(height: 4),
        // ── "PUZZLE" text with puzzle piece decorations ──────────────
        _buildPuzzleText(),
      ],
    );
  }

  Widget _buildBlockText() {
    final letters = ['B', 'L', 'O', 'C', 'K'];
    final colors = [
      const Color(0xFFE74C3C), // B - Red
      const Color(0xFF9B59B6), // L - Purple
      const Color(0xFFF39C12), // O - Orange
      const Color(0xFF27AE60), // C - Green
      const Color(0xFF3498DB), // K - Blue
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(letters.length, (i) {
        return _GlowLetter(letter: letters[i], color: colors[i], fontSize: 52);
      }),
    );
  }

  Widget _buildPuzzleText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left puzzle pieces
        const _PuzzleSquare(color: Color(0xFFF39C12)),
        const SizedBox(width: 4),
        const _PuzzleSquare(color: Color(0xFF3498DB), small: true),
        const SizedBox(width: 6),
        // "PUZZLE" in white with 3D shadow effect
        Stack(
          children: [
            // Shadow layer
            Transform.translate(
              offset: const Offset(2, 3),
              child: Text(
                'PUZZLE',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.black.withValues(alpha: 0.4),
                  letterSpacing: 2,
                ),
              ),
            ),
            // Main text
            const Text(
              'PUZZLE',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        // Right puzzle pieces
        const _PuzzleSquare(color: Color(0xFF27AE60), small: true),
        const SizedBox(width: 4),
        const _PuzzleSquare(color: Color(0xFF3498DB)),
      ],
    );
  }
}

class _GlowLetter extends StatelessWidget {
  final String letter;
  final Color color;
  final double fontSize;

  const _GlowLetter({
    required this.letter,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow shadow
        Text(
          letter,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: color.withValues(alpha: 0.4),
            letterSpacing: 1,
            shadows: [
              Shadow(color: color.withValues(alpha: 0.6), blurRadius: 12),
            ],
          ),
        ),
        // 3D bottom shadow
        Transform.translate(
          offset: const Offset(1.5, 3),
          child: Text(
            letter,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: color.withValues(alpha: 0.5),
              letterSpacing: 1,
            ),
          ),
        ),
        // Main colored letter
        Text(
          letter,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 1,
            shadows: [
              Shadow(
                  color: color.withValues(alpha: 0.8),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
              Shadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 4,
                  offset: const Offset(1, 2)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PuzzleSquare extends StatelessWidget {
  final Color color;
  final bool small;
  const _PuzzleSquare({required this.color, this.small = false});

  @override
  Widget build(BuildContext context) {
    final size = small ? 10.0 : 16.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4),
        ],
      ),
    );
  }
}
