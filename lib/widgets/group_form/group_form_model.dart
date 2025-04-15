import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/domain/entity/group.dart';

class GroupFormModel {
  var groupName = '';
  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox('groups_box');
    final group = groupName;
    await box.add(group);
    Navigator.of(context).pop();
  }
}

class GroupFormModelProvider extends InheritedWidget {
  final GroupFormModel model;

  const GroupFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static GroupFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupFormModelProvider>();
  }

  static GroupFormModelProvider? read(BuildContext context) {
    final element =
        context
            .getElementForInheritedWidgetOfExactType<GroupFormModelProvider>();
    final widget = element?.widget;
    return widget is GroupFormModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupFormModelProvider oldWidget) {
    return oldWidget.model != model;
  }
}
