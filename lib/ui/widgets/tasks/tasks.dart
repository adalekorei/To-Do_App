import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/ui/widgets/tasks/tasks_model.dart';

class Tasks extends StatefulWidget {
  final int groupKey;
  const Tasks({super.key, required this.groupKey});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late final TasksModel _model;

  @override
  void initState() {
    super.initState();
   _model = TasksModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TasksModelProvider(
      model: _model,
      child: const TasksBody(),
    );
  }
}

class TasksBody extends StatelessWidget {
  const TasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Tasks';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(232, 180, 121, 248),
        centerTitle: true,
      ),
      body: const _TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TasksModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRow(indexInList: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _TaskListRow extends StatelessWidget {
  final int indexInList;
  const _TaskListRow({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

@override
Widget build(BuildContext context) {
  final model = TasksModelProvider.read(context)?.model;
  if (model == null || indexInList >= model.tasks.length) {
    return const SizedBox(); 
  }

  final task = model.tasks[indexInList];

  final icon = task.isDone ? Icons.done : null;
  final style = task.isDone
      ? const TextStyle(
          decoration: TextDecoration.lineThrough,
        )
      : null;

  return Slidable(
    startActionPane: const ActionPane(
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: null, 
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) => model.doneToggle(indexInList),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: task.isDone ? Icons.undo : Icons.check,
          label: task.isDone ? 'Undo' : 'Done',
        ),
      ],
    ),
    child: ColoredBox(
      color: Colors.white,
      child: ListTile(
        title: Text(
          task.text,
          style: style,
        ),
        trailing: Icon(icon),
        onTap: () => model.doneToggle(indexInList),
      ),
    ),
  );
}}