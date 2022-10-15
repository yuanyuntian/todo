import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge(
      {Key? key,
      required this.codePoint,
      required this.color,
      required this.id,
      this.size = 30,
      this.outlineColor = Colors.lightGreen})
      : super(key: key);

  final int codePoint;
  final Color color;
  final String id;
  final double? size;
  final Color outlineColor;
  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: id,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: outlineColor)),
          child: Icon(
            IconData(codePoint, fontFamily: 'MaterialIcons'),
            color: color,
            size: size,
          ),
        ));
  }
}
