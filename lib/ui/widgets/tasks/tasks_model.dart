import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/task.dart';
import 'package:todo_app/ui/navigation/main_navigation.dart';
import 'package:todo_app/ui/widgets/tasks/tasks.dart';

class TasksModel extends ChangeNotifier {
  TaskConfiguration configuration;
  late final Future<Box<Task>> _box;
  ValueListenable<Object>? _listenableBox;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  TasksModel({required this.configuration}) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(NavigationRoutes.tasksForm, arguments: configuration.groupKey);
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    task?.save();
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTasksFromHive);
  }

  @override
  Future<void> dispose() async {
    _listenableBox?.removeListener(_readTasksFromHive);
    super.dispose();
  }
}

class TasksModelProvider extends InheritedNotifier {
  final TasksModel model;
  const TasksModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TasksModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksModelProvider>();
  }

  static TasksModelProvider? read(BuildContext context) {
    final widget =
        context
            .getElementForInheritedWidgetOfExactType<TasksModelProvider>()
            ?.widget;
    return widget is TasksModelProvider ? widget : null;
  }
}
