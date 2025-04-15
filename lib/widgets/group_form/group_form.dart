import 'package:flutter/material.dart';
import 'package:todo_app/widgets/group_form/group_form_model.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroupFormState();
  }
}

class _GroupFormState extends State<GroupForm> {
  final _model = GroupFormModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormModelProvider(model: _model, child: const GroupFormBody());
  }
}

class GroupFormBody extends StatelessWidget {
  const GroupFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Creating note'),
        backgroundColor: const Color.fromARGB(255, 205, 146, 233),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: GroupName(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => GroupFormModelProvider.read(context)?.model.saveGroup(context),
        child: Icon(Icons.done),
      ),
    );
  }
}

class GroupName extends StatelessWidget {
  const GroupName({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GroupFormModelProvider.read(context)?.model;
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Group name',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
      autofocus: true,
    );
  }
}
