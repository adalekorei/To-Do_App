import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/task_form/task_form_model.dart';

class TaskForm extends StatefulWidget {
  final int groupKey;
  const TaskForm({super.key, required this.groupKey});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TaskFormModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormModelProvider(model: _model, child: const _TextFormBody());
  }
}

class _TextFormBody extends StatelessWidget {
  const _TextFormBody();

  @override
  Widget build(BuildContext context) {
    final model = TaskFormModelProvider.watch(context)?.model;
    final actionButton = FloatingActionButton(
      onPressed: () => model?.saveTask(context),
      child: const Icon(Icons.done),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('New mini note'),
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
      floatingActionButton: model?.isValid == true ? actionButton : null,
    );
  }
}

class _TaskText extends StatelessWidget {
  const _TaskText();

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
        hintText: 'Type here',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
