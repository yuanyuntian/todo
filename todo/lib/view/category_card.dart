import 'package:flutter/material.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/view/category_detail.dart';
import 'package:todo/view/component/badge.dart';
import 'package:todo/view/component/tasks_progress_indicator.dart';

typedef TaskGetter<T, V> = V Function(T value);

class CategroyCard extends StatelessWidget {
  const CategroyCard(
      {Key? key,
      required this.task,
      required this.color,
      required this.backdropKey,
      required this.getTotalTodos,
      required this.getHeroIds,
      required this.getTaskCompletionPercent})
      : super(key: key);

  final Task task;
  final Color color;
  final GlobalKey backdropKey;

  final TaskGetter<Task, int> getTotalTodos;
  final TaskGetter<Task, HeroId> getHeroIds;
  final TaskGetter<Task, int> getTaskCompletionPercent;

  @override
  Widget build(BuildContext context) {
    var heroIds = getHeroIds(task);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CategoryDetail(taskId: task.id, heroIds: heroIds);
        }));
      },
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Badge(
                    codePoint: task.codePoint,
                    color: ColorUtils.getColorFrom(id: task.color),
                    id: heroIds.codePointId),
                const Spacer(
                  flex: 8,
                ),
                Container(
                  margin: EdgeInsets.zero,
                  child: Hero(
                      tag: heroIds.remainingTaskId,
                      child: Text(
                        '${getTotalTodos(task)} task',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey[500]),
                      )),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  child: Hero(
                      tag: heroIds.titleId,
                      child: Text(task.name,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.black54))),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.zero,
                  child: Hero(
                      tag: heroIds.progressId,
                      child: TasksProgressIndicator(
                        color: color,
                        progress: getTaskCompletionPercent(task),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
