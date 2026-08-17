import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';
import '../../controller/play_screen_controller.dart';

class LevelCompleteDialog extends StatefulWidget {
  final PlayScreenController controller;

  const LevelCompleteDialog({super.key, required this.controller});

  static Future<void> show(BuildContext context, PlayScreenController controller) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "LevelCompleteDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return LevelCompleteDialog(controller: controller);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final scaleCurve = anim1.status == AnimationStatus.reverse
            ? Curves.easeIn
            : Curves.easeOutBack;
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: scaleCurve),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  State<LevelCompleteDialog> createState() => _LevelCompleteDialogState();
}

class _LevelCompleteDialogState extends State<LevelCompleteDialog> {
  bool _buttonsEnabled = false;
  late int _starsEarned;

  @override
  void initState() {
    super.initState();
    final ctrl = widget.controller;
    final int minMoves = ctrl.puzzle?.minMoves ?? 10;
    _starsEarned = ctrl.moves <= minMoves ? 3 : (ctrl.moves <= (minMoves * 1.5).round() ? 2 : 1);

    // Calculate total animation duration to enable buttons:
    // Star 1 delay: 500ms
    // Star 2 delay: 1000ms
    // Star 3 delay: 1500ms
    // Each star animates for 600ms
    final int initialDelayMs = 500;
    final int staggerDelayMs = 500;
    final int animationDurationMs = 600;

    final int totalTime = _starsEarned > 0
        ? initialDelayMs + (_starsEarned - 1) * staggerDelayMs + animationDurationMs
        : initialDelayMs;

    Future.delayed(Duration(milliseconds: totalTime), () {
      if (mounted) {
        setState(() {
          _buttonsEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final int minMoves = ctrl.puzzle?.minMoves ?? 10;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ── Main Dialog Container ─────────────────────────────────
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 28), // Space for header ribbon
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.surface, AppColors.homeNavyDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: const Color(0xFFFBBF24), // Golden frame
                width: 6,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: const Color(0xFFD97706).withValues(alpha: 0.15), // Outer gold glow
                  blurRadius: 32,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),

                // ── Stars Row (Curved Arc Layout) ───────────────────────
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Star 1 (Left)
                      Transform.rotate(
                        angle: -0.2,
                        child: Transform.translate(
                          offset: const Offset(0, 10),
                          child: AnimatedStar(
                            isEarned: _starsEarned >= 1,
                            delay: const Duration(milliseconds: 500),
                            size: 58,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Star 2 (Middle)
                      Transform.translate(
                        offset: const Offset(0, -10),
                        child: AnimatedStar(
                          isEarned: _starsEarned >= 2,
                          delay: const Duration(milliseconds: 1000),
                          size: 76,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Star 3 (Right)
                      Transform.rotate(
                        angle: 0.2,
                        child: Transform.translate(
                          offset: const Offset(0, 10),
                          child: AnimatedStar(
                            isEarned: _starsEarned >= 3,
                            delay: const Duration(milliseconds: 1500),
                            size: 58,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'LEVEL ${ctrl.currentLevel} COMPLETED!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary, // Slate grey
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                // ── Stats Box ──────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.homeNavyDark, // Light inset background
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.homeCardBorder, // Slate border
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('MOVES', '${ctrl.moves}'),
                      Container(width: 2, height: 32, color: AppColors.divider),
                      _buildStatItem('TARGET', '$minMoves'),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── Action Buttons Row ─────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Home Button
                    UnityButton(
                      width: 60,
                      height: 60,
                      baseColor: const Color(0xFF3B82F6),
                      shadowColor: const Color(0xFF1E3A8A),
                      gradientColors: const [Color(0xFF60A5FA), Color(0xFF2563EB)],
                      onTap: _buttonsEnabled
                          ? () {
                              Navigator.of(context).pop(); // Close dialog
                              Navigator.of(
                                context,
                              ).pop(); // Close PlayScreen (exit to LevelSelection/Dashboard)
                            }
                          : null,
                      child: const Icon(Icons.home_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    // Next Level Button (Main Action)
                    Expanded(
                      child: UnityButton(
                        width: 140,
                        height: 60,
                        baseColor: const Color(0xFF10B981),
                        shadowColor: const Color(0xFF064E3B),
                        gradientColors: const [Color(0xFF34D399), Color(0xFF059669)],
                        onTap: _buttonsEnabled
                            ? () {
                                Navigator.of(context).pop();
                                ctrl.loadNextLevel();
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'NEXT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.play_arrow_rounded, color: Colors.white, size: 26),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Replay Button
                    UnityButton(
                      width: 60,
                      height: 60,
                      baseColor: const Color(0xFFF59E0B),
                      shadowColor: const Color(0xFF78350F),
                      gradientColors: const [Color(0xFFFBBF24), Color(0xFFD97706)],
                      onTap: _buttonsEnabled
                          ? () {
                              Navigator.of(context).pop();
                              ctrl.onRestart();
                            }
                          : null,
                      child: const Icon(Icons.replay_rounded, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Ribbon Banner Header ──────────────────────────────────
          Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFEF4444), // Red
                    Color(0xFFF97316), // Orange
                    Color(0xFFEF4444), // Red
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFEF08A), // Light yellow highlights
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'VICTORY!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  shadows: [Shadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 4)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary, // Slate 500
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary, // Dark slate text color for readability
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ── Animated Star Widget with elastic/bounce scaling ───────────────
class AnimatedStar extends StatefulWidget {
  final bool isEarned;
  final Duration delay;
  final double size;

  const AnimatedStar({super.key, required this.isEarned, required this.delay, required this.size});

  @override
  State<AnimatedStar> createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    if (widget.isEarned) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          setState(() {
            _isAnimating = true;
          });
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Base grey/white star:
    final Widget baseStar = Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.star_rounded, color: Colors.black.withValues(alpha: 0.08), size: widget.size + 4),
        Icon(Icons.star_rounded, color: const Color(0xFFE2E8F0), size: widget.size),
      ],
    );

    if (!widget.isEarned) {
      return baseStar;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        baseStar,
        ScaleTransition(
          scale: _scaleAnimation,
          child: _isAnimating
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.black.withValues(alpha: 0.2),
                      size: widget.size + 4,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFFDF00), Color(0xFFFFB300), Color(0xFFFF8F00)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Icon(Icons.star_rounded, color: Colors.white, size: widget.size),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}


