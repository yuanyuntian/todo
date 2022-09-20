import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Color color;

  const GradientBackground({Key ? key, required this.child, required this.color}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.3,0.5,0.7,0.9],
          colors: getColorList(color),
        )
      ),
      curve: Curves.linear,
      child: child
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
