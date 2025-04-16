import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form_model.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

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
  const _GroupFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
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
  const _GroupName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Group name',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}