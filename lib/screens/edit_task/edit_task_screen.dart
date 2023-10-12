import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/edit_task/widgets/edit_task_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatelessWidget {
  static String routeName = "edit-task-screen";
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_task,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: EditTaskBody(taskModel: taskModel),
    );
  }
}
