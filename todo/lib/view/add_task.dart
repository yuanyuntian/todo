import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/scopedmodel/list_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/view/component/badge.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key, required this.taskId, required this.heroId})
      : super(key: key);

  final String taskId;
  final HeroId heroId;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newTask = '';
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListModel>(builder: builder);
  }

  Widget builder(BuildContext context, Widget? child, ListModel model) {
    if (model.tasks.isEmpty) {
      return Container(
        color: Colors.white,
      );
    }
    var _task =
        model.tasks.firstWhere((element) => element.id == widget.taskId);
    var _color = ColorUtils.getColorFrom(id: _task.color);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'New Task',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: _color),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What task are you planning to perfrom?',
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(
              height: 16.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newTask = value;
                });
              },
              cursorColor: _color,
              autofocus: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your Task...',
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
                Badge(
                    codePoint: _task.codePoint,
                    color: _color,
                    id: widget.heroId.codePointId),
                Container(
                  width: 16.0,
                ),
                Hero(
                    tag: 'not_using_right_now',
                    child: Text(
                      _task.name,
                      style: const TextStyle(
                          color: Colors.black38, fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (newTask.isEmpty) {
            const snackBar = SnackBar(
              content: Text(
                  'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
              backgroundColor: Colors.white,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            model.addTodo(Todo(newTask, parent: _task.id));
            Navigator.pop(context);
          }
        },
        label: const Text('Create Task'),
        icon: const Icon(Icons.add),
        backgroundColor: _color,
        heroTag: 'fab_new_task',
      ),
    );
  }
}
