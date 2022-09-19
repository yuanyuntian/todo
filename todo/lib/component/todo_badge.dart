import 'package:flutter/material.dart';

class TodoBadge extends StatelessWidget {

  final int codePoint;
  final Color color;
  final String id;
  final double? size;
  final Color outlineColor;


  TodoBadge({
    required this.codePoint, 
    required this.color,
    required this.id,
    Color? outlineColor,
    this.size
  }):outlineColor = outlineColor ?? Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}