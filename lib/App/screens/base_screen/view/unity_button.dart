import 'package:flutter/material.dart';

class UnityButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color baseColor;
  final Color shadowColor;
  final List<Color> gradientColors;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double borderWidth;
  final double shadowHeight;

  const UnityButton({
    super.key,
    required this.child,
    this.onTap,
    required this.baseColor,
    required this.shadowColor,
    required this.gradientColors,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 20.0,
    this.borderWidth = 2.0,
    this.shadowHeight = 6.0,
  });

  @override
  State<UnityButton> createState() => _UnityButtonState();
}

class _UnityButtonState extends State<UnityButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onTap != null;
    final double shadowHeight = widget.shadowHeight;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onTap?.call();
            }
          : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: (widget.margin ?? EdgeInsets.zero).add(
          EdgeInsets.only(
            top: _isPressed ? shadowHeight : 0.0,
            bottom: _isPressed ? 0.0 : shadowHeight,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            colors: isEnabled
                ? widget.gradientColors
                : [Colors.grey.shade400, Colors.grey.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            color: isEnabled ? Colors.white.withValues(alpha: 0.4) : Colors.white24,
            width: widget.borderWidth,
          ),
          boxShadow: _isPressed
              ? []
              : [
                  // 3D bottom bezel shadow
                  BoxShadow(
                    color: isEnabled ? widget.shadowColor : Colors.grey.shade600,
                    offset: Offset(0, shadowHeight),
                  ),
                  // Subtle ambient shadow
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: Offset(0, shadowHeight + 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
