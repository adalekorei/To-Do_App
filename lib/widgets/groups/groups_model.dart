import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroupsModel extends ChangeNotifier {
  var _groups = [];

  List get groups => _groups.toList();

  GroupsModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form');
  }

  void deleteGroup(int indexList) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox('groups_box');
    await box.deleteAt(indexList);
  }

  void _readGroupsFromHive(Box<dynamic> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox('groups_box');
    _readGroupsFromHive(box);
    box.listenable().addListener(() {
      _readGroupsFromHive(box);
    });
  }
}

class GroupsModelProvider extends InheritedNotifier {
  final GroupsModel model;

  const GroupsModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static GroupsModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupsModelProvider>();
  }

  static GroupsModelProvider? read(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<GroupsModelProvider>();
    final widget = element?.widget;
    return widget is GroupsModelProvider ? widget : null;
  }
}
