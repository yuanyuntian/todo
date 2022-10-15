import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key, required this.child, required this.color})
      : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: getColorList(color),
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.3, 0.5, 0.7, 0.9])),
      child: child,
    );
  }

  List<Color> getColorList(Color color) {
    if (color is MaterialColor) {
      return [
        color.shade300,
        color.shade600,
        color.shade700,
        color.shade900,
      ];
    } else {
      return List<Color>.filled(4, color);
    }
  }
}
