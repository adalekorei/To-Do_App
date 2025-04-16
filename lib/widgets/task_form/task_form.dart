import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/task_form/task_form_model.dart';
import 'package:todo_app/widgets/tasks/tasks_model.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TaskFormModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormModel.TaskFormModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormModelProvider(
      model: _model!,
      child: const _TextFormBody(),
    );
  }
}

class _TextFormBody extends StatelessWidget {
  const _TextFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New task'),
        backgroundColor: const Color.fromARGB(232, 180, 121, 248),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaskText(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TaskFormModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskText extends StatelessWidget {
  const _TaskText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task text',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}