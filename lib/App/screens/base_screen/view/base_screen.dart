import 'package:colours/App/core/constants/color_constants.dart';
import 'package:colours/App/core/utils/common.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    this.appBar,
    this.drawer,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.padding,
    this.useGradientBackground = false,
    this.gradientColors,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
  });

  final PreferredSizeWidget? appBar;
  final Drawer? drawer;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  /// When true, renders a gradient instead of a solid background color.
  final bool useGradientBackground;
  final List<Color>? gradientColors;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      backgroundColor:
          useGradientBackground ? Colors.transparent : (backgroundColor ?? AppColors.backgroundColor),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: useGradientBackground
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors ?? AppColors.splashGradient,
                ),
              ),
              child: GestureDetector(
                onTap: removeFocus,
                child: padding == null
                    ? body
                    : Padding(padding: padding!, child: body),
              ),
            )
          : GestureDetector(
              onTap: removeFocus,
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 18),
                child: body,
              ),
            ),
    );
  }
}