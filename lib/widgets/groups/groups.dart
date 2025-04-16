import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/groups/groups_model.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final model = GroupsModel();

  @override
  Widget build(BuildContext context) {
    return GroupsModelProvider(
      model: model,
      child: const _GroupsBody(),
    );
  }
}

class _GroupsBody extends StatelessWidget {
  const _GroupsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Groups'),
        backgroundColor: const Color.fromARGB(232, 180, 121, 248),
      ),
      body: const _GroupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupsModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupList extends StatelessWidget {
  const _GroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRow(indexInList: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _GroupListRow extends StatelessWidget {
  final int indexInList;
  const _GroupListRow({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

@override
Widget build(BuildContext context) {
  final model = GroupsModelProvider.read(context)!.model;
  final group = model.groups[indexInList];

  return Slidable(
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => model.deleteGroup(indexInList),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: ColoredBox(
      color: Colors.white,
      child: ListTile(
        title: Text(group.name),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => model.showTasks(context, indexInList),
      ),
    ),
  );
}}