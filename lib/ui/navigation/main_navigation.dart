import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/group_form/group_form.dart';
import 'package:todo_app/ui/widgets/groups/groups.dart';
import 'package:todo_app/ui/widgets/task_form/task_form.dart';
import 'package:todo_app/ui/widgets/tasks/tasks.dart';

abstract class NavigationRoots {
  static const groups = '/';
  static const groupsForm = '/form';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = NavigationRoots.groups;
  final routes = {
    NavigationRoots.groups: (context) => const Groups(),
    NavigationRoots.groupsForm: (context) => const GroupForm(),
  };

  Route<Object> OnGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoots.tasks:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return Tasks(groupKey: groupKey);
          },
        );
      case NavigationRoots.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TaskForm(groupKey: groupKey);
          },
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
    }
  }
}
