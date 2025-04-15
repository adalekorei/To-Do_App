import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/groups/groups_model.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroupsState();
  }
}

class _GroupsState extends State<Groups> {
  final model = GroupsModel();
  @override
  Widget build(BuildContext context) {
    return GroupsModelProvider(model: model, child: GroupsBody());
  }
}

class GroupsBody extends StatelessWidget {
  const GroupsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your TO-DO App'),
        backgroundColor: const Color.fromARGB(255, 205, 146, 233),
      ),
      body: const GroupList(),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => GroupsModelProvider.read(context)?.model.showForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GroupRow(indexList: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
      itemCount: groupsCount,
    );
  }
}

class GroupRow extends StatelessWidget {
  final int indexList;
  const GroupRow({super.key, required this.indexList});

  @override
  Widget build(BuildContext context) {

    final model = GroupsModelProvider.read(context)!.model;
    final group = model.groups[indexList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => model.deleteGroup(indexList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
