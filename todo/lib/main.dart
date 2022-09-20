import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/scopedmodel/todo_list_model.dart';
import 'package:todo/utils/color_utils.dart';
import 'package:todo/utils/datetime_utils.dart';

import 'component/gradient_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
            subtitle1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
            ),
          )),
      home: const MyHomePage(title: ''),
    );
    return ScopedModel<TodoListModel>(model: TodoListModel(), child: app);
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key ?key, required this.title}):super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  String currentDay(BuildContext context) {
    return DateTimeUtils.currentDay;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  final int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (context, child, model) {
        var _isLoading = model.isLoading;
        var _tasks = model.tasks;
        var _todos = model.todos;

        var backgroundColor = _tasks.isEmpty || _tasks.length == _currentPageIndex
          ? Colors.blueGrey
          : ColorUtils.getColorFrom(id: _tasks[_currentPageIndex].color);

        return GradientBackground(
          color:backgroundColor,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(widget.title),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white30),
              ),
            ),
          )
        );
      },
    );
  }
}
