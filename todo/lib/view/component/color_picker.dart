import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../utils/color_utils.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker(
      {Key? key, required this.defaultColor, required this.onColorChange})
      : super(key: key);

  final Color defaultColor;
  final ValueChanged<Color> onColorChange;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 40,
        width: 40,
        color: defaultColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        availableColors: ColorUtils.defaultColors,
                        pickerColor: defaultColor,
                        onColorChanged: onColorChange,
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
