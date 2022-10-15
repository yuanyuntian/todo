import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/scopedmodel/list_model.dart';

// ignore: library_prefixes
import 'component/color_picker.dart' as TColorPicker;
import 'component/icon_picker_builder.dart';

class EditCategory extends StatefulWidget {
  const EditCategory(
      {Key? key,
      required this.taskId,
      required this.taskName,
      required this.color,
      required this.icon})
      : super(key: key);

  final String taskId;
  final String taskName;
  final Color color;
  final IconData icon;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late String taskName;
  late Color taskColor;
  late IconData taskIcon;

  final btnSaveTitle = "Save Changes";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskName = widget.taskName;
    taskColor = widget.color;
    taskIcon = widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListModel>(builder: builder);
  }

  Widget builder(BuildContext context, Widget? child, ListModel model) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Edit Category',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: taskColor),
          backgroundColor: Colors.white,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category will help you group related task!',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  height: 16.0,
                ),
                TextFormField(
                  initialValue: taskName,
                  onChanged: (value) {
                    setState(() {
                      taskName = value;
                    });
                  },
                  cursorColor: taskColor,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category Name',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
                    TColorPicker.ColorPicker(
                      defaultColor: taskColor,
                      onColorChange: (value) {
                        setState(() {
                          taskColor = value;
                        });
                      },
                    ),
                    Container(
                      width: 22,
                    ),
                    IconPickerBuilder(
                      icon: taskIcon,
                      borderColor: taskColor,
                      action: (value) {
                        setState(() {
                          taskIcon = value;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildfloatButton(context, model));
  }

  Widget buildfloatButton(BuildContext context, ListModel model) {
    return FloatingActionButton.extended(
        onPressed: () {
          if (taskName.isEmpty) {
            final snackBar = SnackBar(
              content: const Text(
                  'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
              backgroundColor: taskColor,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            model.updateTask(Task(taskName,
                color: taskColor.value,
                codePoint: taskIcon.codePoint,
                id: widget.taskId));
            Navigator.pop(context);
          }
        },
        heroTag: 'fab_new_card',
        icon: const Icon(Icons.save),
        backgroundColor: taskColor,
        label: Text(btnSaveTitle));
  }
}
