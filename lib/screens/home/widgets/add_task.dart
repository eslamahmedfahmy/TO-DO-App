import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/providers/list_provider.dart';
import 'package:todo_app/screens/home/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  // String currentDate = DateFormat.yMd().format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String taskTitle = "";
  String taskDescription = "";
  late ListsProvider listsProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);
    listsProvider = Provider.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.new_task,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: appConfig.isDarkTheme()
                        ? Colors.white
                        : MyTheme.blackColorLightMode,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                      onChangedFunction: (value) {
                        taskTitle = value;
                      },
                      hintText: AppLocalizations.of(context)!.task_title,
                      validationMessage:
                          AppLocalizations.of(context)!.task_title_validation),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChangedFunction: (value) {
                      taskDescription = value;
                    },
                    hintText: AppLocalizations.of(context)!.task_description,
                    validationMessage: AppLocalizations.of(context)!
                        .task_description_validation,
                    maxLines: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.select_date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await showCursomDatePicker();
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: MyTheme.primaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    DateFormat.yMd().format(selectedDate),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(
                            horizontal: 100,
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          MyTheme.primaryColor,
                        ),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        TaskModel task = TaskModel(
                          title: taskTitle,
                          description: taskDescription,
                          dateTime: selectedDate,
                        );
                        await addTask(task);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showCursomDatePicker() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate == null) {
      return;
    }
    setState(() {});

    selectedDate = chosenDate;
  }

  Future<void> addTask(TaskModel task) async {
    listsProvider.addTask(task).timeout(const Duration(milliseconds: 1),
        onTimeout: () {
      listsProvider
          .getAllTasks()
          .timeout(const Duration(milliseconds: 100), onTimeout: () {});
    });
    showTopSnackBar(
      displayDuration: const Duration(seconds: 2),
      Overlay.of(context),
      CustomSnackBar.success(
        message: AppLocalizations.of(context)!.add_message,
      ),
    );
    Navigator.pop(context);
  }
}
