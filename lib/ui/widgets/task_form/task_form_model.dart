import 'package:flutter/material.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/task.dart';

class TaskFormModel {
  final int groupKey;
  var taskText = '';

  TaskFormModel.TaskFormModel({required this.groupKey});
  TaskFormModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;

    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    Navigator.of(context).pop();
    await BoxManager.instance.closeBox(box);
  }
}

class TaskFormModelProvider extends InheritedWidget {
  final TaskFormModel model;

  const TaskFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static TaskFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormModelProvider>();
  }

  static TaskFormModelProvider? read(BuildContext context) {
    final widget =
        context
            .getElementForInheritedWidgetOfExactType<TaskFormModelProvider>()
            ?.widget;
    return widget is TaskFormModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormModelProvider oldWidget) {
    return false;
  }
}
