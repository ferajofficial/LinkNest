import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  // Size and layout
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // Style
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? border;

  // Text style
  final TextStyle? textStyle;

  // Loading state
  final bool isLoading;
  final Widget? loadingIndicator;

  // Disabled state
  final bool isDisabled;

  const GlobalButton({
    Key? key,
    required this.child,
    required this.onPressed,

    // Layout
    this.width,
    this.height,
    this.padding,
    this.margin,

    // Styling
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.elevation,
    this.borderRadius,
    this.border,

    // Text styling
    this.textStyle,

    // Loading and disabled
    this.isLoading = false,
    this.loadingIndicator,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? loadingIndicator ??
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor ?? Colors.white,
              ),
            )
        : child;

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: shadowColor,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: border ?? BorderSide.none,
          ),
          padding: padding,
        ),
        child: buttonChild,
      ),
    );
  }
}