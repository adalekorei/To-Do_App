import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form.dart';
import 'package:todo_app/widgets/groups/groups.dart';
import 'package:todo_app/widgets/task_form/task_form.dart';
import 'package:todo_app/widgets/task_form/task_form_model.dart';
import 'package:todo_app/widgets/tasks/tasks.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      routes: {
        '/groups': (context) => const Groups(),
        '/groups/form': (context) => const GroupForm(),
        '/groups/tasks': (context) => const Tasks(),
        '/groups/tasks/form': (context) => const TaskForm(),
      },
      initialRoute: '/groups',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}