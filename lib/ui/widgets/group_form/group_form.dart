import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/group_form/group_form_model.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final _model = GroupFormModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormModelProvider(
      model: _model,
      child: const _GroupFormBody(),
    );
  }
}

class _GroupFormBody extends StatelessWidget {
  const _GroupFormBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        backgroundColor: const Color.fromARGB(232, 180, 121, 248),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _GroupName(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupFormModelProvider.read(context)
            ?.model
            .saveGroup(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupName extends StatelessWidget {
  const _GroupName();

  @override
  Widget build(BuildContext context) {
    final model = GroupFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Note name',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}