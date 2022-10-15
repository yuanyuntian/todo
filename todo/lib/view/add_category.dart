import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/scopedmodel/list_model.dart';

import 'package:todo/utils/color_utils.dart';
import 'package:scoped_model/scoped_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddCategory> {
  late String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  late Color color;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    title = '';
    color = ColorUtils.defaultColors[0];
    icon = Icons.work;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListModel>(
        builder: (BuildContext context, Widget? child, ListModel model) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'New Category',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Category will help you group related task!',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
              ),
              Container(
                height: 16,
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                },
                cursorColor: color,
                autofocus: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Category Name...',
                    hintStyle: TextStyle(color: Colors.black26)),
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 36.0),
              ),
              Container(
                height: 26,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColorPicker(
                      pickerColor: color,
                      onColorChanged: (Color selectedColor) {
                        setState(() {
                          color = selectedColor;
                        });
                      }),
                  Container(width: 22),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (title.isEmpty) {
              const snackBar = SnackBar(
                content: Text(
                    'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                backgroundColor: Colors.white,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              model.addTask(
                  Task(title, color: color.value, codePoint: icon.codePoint));

              Navigator.pop(context);
            }
          },
          label: const Text('Create New Card'),
          icon: const Icon(Icons.save),
          backgroundColor: color,
          heroTag: 'fab_new_card',
        ),
      );
    });
  }
}
