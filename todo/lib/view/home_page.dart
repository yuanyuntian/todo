import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:todo/scopedmodel/list_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/view/category_card.dart';
import 'package:todo/view/categrory_card_new.dart';
import 'package:todo/view/component/gradient_background.dart';
import 'package:todo/view/component/privacy_policy.dart';

import '../model/choice_card.dart';
import '../model/hero_id_model.dart';
import '../model/task_model.dart';
import '../utils/datetime_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  HeroId _generateHeroIds(Task task) {
    return HeroId(
      'code_point_id_${task.id}',
      'progress_id_${task.id}',
      'title_id_${task.id}',
      'remaining_task_id_${task.id}',
    );
  }

  String currentDay(BuildContext context) {
    return DateTimeUtils.currentDay;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'backdrop');

  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _animation =
        Tween<double>(begin: 0, end: 1.0).animate(_animationController);

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListModel>(builder: builderHomePage);
  }

  Widget builderHomePage(BuildContext context, Widget? child, ListModel model) {
    var _isloading = model.isLoading;
    var _tasks = model.tasks;
    var _todos = model.todos;
    var backgroundColor = _tasks.isEmpty || _tasks.length == _currentPageIndex
        ? Colors.blueGrey
        : ColorUtils.getColorFrom(id: _tasks[_currentPageIndex].color);

    if (!_isloading) {
      _animationController.forward();
    }
    return GradientBackground(
      color: backgroundColor,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              PopupMenuButton<Choice>(
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(choice.title,
                              style: const TextStyle(
                                fontSize: 20,
                              )),
                          const Spacer(),
                          Icon(choice.icon, color: backgroundColor)
                        ],
                      ),
                    );
                  }).toList();
                },
                onSelected: (value) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              )
            ],
          ),
          body: _isloading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : FadeTransition(
                  opacity: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              child: Text(
                                '${widget.currentDay(context)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            Text(
                              '${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(height: 16.0),
                            Text(
                              'You have ${_todos.where((todo) => todo.isCompleted == 0).length} tasks to complete',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(
                              height: 16.0,
                            )
                          ],
                        ),
                      ),
                      builderPages(_tasks, model, widget),
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                      )
                    ],
                  ),
                )),
    );
  }

  Widget builderPages(List<Task> tasks, ListModel model, HomePage widget) {
    return Expanded(
      key: _backdropKey,
      flex: 1,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            print('ScrollNotification = ${_pageController.page}');

            var currentPage = _pageController.page?.round().toInt() ?? 0;
            if (_currentPageIndex != currentPage) {
              setState(() {
                _currentPageIndex = currentPage;
              });
            }
          }
          return true;
        },
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            if (index == tasks.length) {
              return const CategoryCardNew(color: Colors.blueGrey);
            } else {
              // return const CategoryCardNew(color: Colors.blueGrey);

              return CategroyCard(
                  task: tasks[index],
                  color: ColorUtils.getColorFrom(id: tasks[index].color),
                  backdropKey: _backdropKey,
                  getTotalTodos: model.getTotalTodosFrom,
                  getHeroIds: widget._generateHeroIds,
                  getTaskCompletionPercent: model.getTaskCompletionPercent);
            }
          },
          itemCount: tasks.length + 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
}
