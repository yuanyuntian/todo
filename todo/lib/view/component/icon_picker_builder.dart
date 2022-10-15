import 'package:flutter/material.dart';
import 'package:todo/view/component/badge.dart';
import 'package:todo/view/component/icon_picker.dart';

class IconPickerBuilder extends StatelessWidget {
  const IconPickerBuilder(
      {Key? key,
      required this.icon,
      required this.action,
      required this.borderColor})
      : super(key: key);

  final IconData icon;
  final ValueChanged<IconData> action;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Select an icon'),
                content: SingleChildScrollView(
                  child: IconPicker(
                      currentIconData: icon,
                      onIconChanged: action,
                      highlightColor: borderColor),
                ),
              );
            });
      },
      child: Badge(codePoint: icon.codePoint, color: borderColor, id: 'id'),
    );
  }
}
