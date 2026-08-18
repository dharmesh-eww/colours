import 'package:flutter/material.dart';
import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/core/utils/app_text_style.dart';
import 'package:colours/App/screens/base_screen/view/unity_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.backgroundColor,
    this.centerTitle = true,
  });

  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final Color? backgroundColor;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: showBackButton ? _buildBackButton(context) : (leading),
      title:
          title ??
          (titleText != null
              ? ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(colors: AppColors.primaryGradient).createShader(bounds),
                  child: Text(titleText!, style: AppTextStyle.boldWhite(fontSize: 20)),
                )
              : null),
      actions: actions,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return UnityButton(
      width: 44,
      height: 44,
      margin: const EdgeInsets.all(8),
      borderRadius: 12.0,
      borderWidth: 1.0,
      shadowHeight: 3.0,
      baseColor: AppColors.cardColor,
      shadowColor: const Color(0xFFCBD5E1),
      gradientColors: const [Colors.white, Color(0xFFF1F5F9)],
      onTap: () => Navigator.maybePop(context),
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 18),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
