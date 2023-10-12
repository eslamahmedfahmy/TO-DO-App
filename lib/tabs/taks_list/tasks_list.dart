import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/list_provider.dart';
import 'package:todo_app/screens/edit_task/edit_task_screen.dart';
import 'package:todo_app/tabs/taks_list/task_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../providers/app_config_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListsProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasks();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: MyTheme.primaryColor),
          child: DatePicker(
            DateTime.now().subtract(const Duration(days: 2)),
            onDateChange: (date) async {
              listProvider.setNewSelectedDate(date);
              await listProvider.getAllTasks();
            },
            daysCount: 365,

            locale: appConfig.appLanguage,

            selectedTextColor: const Color(0xff141922),
            initialSelectedDate: DateTime.now(),
            // selectionColor: MyTheme.primaryColor,
            selectionColor: Colors.white,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, EditTaskScreen.routeName,
                      arguments: listProvider.tasksList[index]);
                },
                child: TaskWidget(task: listProvider.tasksList[index]),
              );
            },
          ),
        )
      ],
    );
  }
}
