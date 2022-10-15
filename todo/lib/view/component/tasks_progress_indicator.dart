import 'package:flutter/material.dart';

class TasksProgressIndicator extends StatelessWidget {
  const TasksProgressIndicator({Key? key, required this.color, this.progress})
      : super(key: key);

  final Color color;
  final progress;

  final _height = 3.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: LayoutBuilder(builder: builder)),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: Text(
            "$progress%",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  Widget builder(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: [
        Container(
          height: _height,
          color: Colors.grey.withOpacity(0.1),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _height,
          width: (progress / 100) * constraints.maxWidth,
          color: color,
        )
      ],
    );
  }
}
