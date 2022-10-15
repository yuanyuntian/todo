import 'package:flutter/material.dart';

typedef Callback = void Function();

class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog(
      {Key? key, required this.color, required this.onActionPressed})
      : super(key: key);

  final Color color;
  final Callback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(context: context, builder: builderDialog);
      },
      icon: const Icon(Icons.delete),
      color: color,
    );
  }

  Widget builderDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete this card?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const [
            Text(
                'This is a one way street! Deleting this will remove all the task assigned in this card.'),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onActionPressed();
            },
            child: const Text('Delete')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ))
      ],
    );
  }
}
