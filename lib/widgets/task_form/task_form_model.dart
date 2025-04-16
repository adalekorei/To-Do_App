
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';

class TaskFormModel {
  int groupKey;
  var taskText = '';

  TaskFormModel.TaskFormModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormModelProvider extends InheritedWidget {
  final TaskFormModel model;

  const TaskFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static TaskFormModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormModelProvider>();
  }

  static TaskFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormModelProvider>()
        ?.widget;
    return widget is TaskFormModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormModelProvider oldWidget) {
    return false;
  }
}