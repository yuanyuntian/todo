import 'package:flutter/material.dart';

class IconPickerBuilder extends StatelessWidget {
  
  final IconData iconData;
  final ValueChanged<IconData> action;
  final Color highlightColor;

  IconPickerBuilder({
    required this.iconData,
    required this.action,
    required Color highlightColor
  }):this.highlightColor = highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
