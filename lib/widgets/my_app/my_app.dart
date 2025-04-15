import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form.dart';
import 'package:todo_app/widgets/groups/groups.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/groups': (context) => const Groups(),
        '/groups/form': (context) => const GroupForm(),
      },
      initialRoute: '/groups',
    );
  }
}
