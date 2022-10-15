import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/scopedmodel/list_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/view/add_task.dart';
import 'package:todo/view/component/badge.dart';
import 'package:todo/view/component/delete_category_dialog.dart';
import 'package:todo/view/component/tasks_progress_indicator.dart';
import 'package:todo/view/edit_category.dart';

import '../model/todo_model.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key, required this.taskId, required this.heroIds})
      : super(key: key);

  final String taskId;
  final HeroId heroIds;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation =
        Tween<Offset>(begin: const Offset(0, 1.0), end: const Offset(0.0, 0.0))
            .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return ScopedModelDescendant<ListModel>(builder: builder);
  }

  Widget builder(BuildContext context, Widget? child, ListModel model) {
    Task _task;
    try {
      _task = model.tasks.firstWhere((element) => element.id == widget.taskId);
    } catch (e) {
      return Container(
        color: Colors.white,
      );
    }
    var _todos = model.todos
        .where((element) => element.parent == widget.taskId)
        .toList();

    var _hero = widget.heroIds;

    var _color = ColorUtils.getMaterialColorFrom(id: _task.color);
    var _icon = IconData(_task.codePoint, fontFamily: 'MaterialIcons');

    return Theme(
        data: ThemeData(primaryColor: _color),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: _color),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditCategory(
                              taskId: _task.id,
                              taskName: _task.name,
                              color: _color,
                              icon: _icon))));
                },
                icon: const Icon(Icons.edit),
                color: _color,
              ),
              DeleteCategoryDialog(
                  color: _color, onActionPressed: () => model.removeTask(_task))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Badge(
                          codePoint: _task.codePoint,
                          color: _color,
                          id: _task.id),
                      const Spacer(
                        flex: 1,
                      ),
                      Hero(
                        tag: _hero.remainingTaskId,
                        child: Text(
                          "${model.getTotalTodosFrom(_task)} Task",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Hero(
                          tag: 'tile_hero_unused',
                          child: Text(
                            _task.name,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 30.0),
                          )),
                      const Spacer(),
                      Hero(
                          tag: _hero.progressId,
                          child: TasksProgressIndicator(
                            color: _color,
                            progress: model.getTaskCompletionPercent(_task),
                          ))
                    ],
                  ),
                ),
                Expanded(child: listViewBuilder(context, model, _todos, _color))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'fab_new_task',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddTask(taskId: _task.id, heroId: _hero)));
            },
            tooltip: 'New Todo',
            backgroundColor: _color,
            child: const Icon(Icons.add),
          ),
        ));
  }

  Widget listViewBuilder(
      BuildContext context, ListModel model, List<Todo> todos, Color color) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == todos.length) {
          return const SizedBox(
            height: 56,
          );
        }
        var todo = todos[index];
        return Container(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            leading: Checkbox(
              onChanged: (value) => model
                  .updateTodo(todo.copy(isCompleted: value == true ? 1 : 0)),
              value: todo.isCompleted == 1 ? true : false,
              activeColor: color,
            ),
            trailing: IconButton(
                onPressed: () {
                  model.removeTodo(todo);
                },
                icon: const Icon(Icons.delete_outline)),
            title: Text(
              todo.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: todo.isCompleted == 1 ? color : Colors.black54,
                decoration: todo.isCompleted == 1
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        );
      },
      itemCount: todos.length,
    );
  }
}
