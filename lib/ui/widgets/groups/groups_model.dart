import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/data_provider/box_manager.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/ui/navigation/main_navigation.dart';
import 'package:todo_app/ui/widgets/tasks/tasks.dart';

class GroupsModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  ValueListenable<Object>? _listenableBox;

  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupsModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationRoutes.groupsForm);
  }

  Future<void> showTasks(BuildContext context, int groupIndex) async {
    final group = (await _box).getAt(groupIndex);
    if (group != null) {
      final configuration = TaskConfiguration(
        group.key as int,
        group.name,
        groupKey: group.key as int,
        title: group.name,
      );
      Navigator.of(
        context,
      ).pushNamed(NavigationRoutes.tasks, arguments: configuration);
    }
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await _box;
    final groupKey = (await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskNamed(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(groupIndex);
  }

  Future<void> _readGroupsFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openGroupBox();
    await _readGroupsFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readGroupsFromHive);
  }

  @override
  Future<void> dispose() async {
    _listenableBox?.addListener(_readGroupsFromHive);
    await BoxManager.instance.closeBox((await _box));
    super.dispose();
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
    final widget =
        context
            .getElementForInheritedWidgetOfExactType<GroupsModelProvider>()
            ?.widget;
    return widget is GroupsModelProvider ? widget : null;
  }
}
