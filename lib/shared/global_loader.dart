import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? bgColor;
  final Color? color;

  const LoadingWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur strength
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: bgColor ?? Colors.white.withOpacity(0.1), // Semi-transparent glass look
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: color ?? Colors.white,
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
