import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';

class HomePlayButton extends StatelessWidget {
  final VoidCallback? onTap;

  const HomePlayButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return UnityButton(
      width: double.infinity,
      height: 80.0,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: 22.0,
      borderWidth: 1.5,
      shadowHeight: 5.0,
      baseColor: AppColors.playButtonGreen,
      shadowColor: AppColors.playButtonGreenDark,
      gradientColors: const [Color(0xFF56C656), AppColors.playButtonGreen],
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Play icon in white circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'PLAY',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: Color(0x66000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Text(
                'Continue Your Journey',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFB8F0B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
