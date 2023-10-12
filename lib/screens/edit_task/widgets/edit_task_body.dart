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

class EditTaskBody extends StatefulWidget {
  const EditTaskBody({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  // String currentDate = DateFormat.yMd().format(DateTime.now());
  late DateTime currentDate;
  late String title;
  late String description;
  late ListsProvider listsProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentDate = widget.taskModel.dateTime ?? DateTime.now();
    title = widget.taskModel.title ?? "";
    description = widget.taskModel.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);
    listsProvider = Provider.of<ListsProvider>(context);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07,
          vertical: MediaQuery.of(context).size.width * 0.1,
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              appConfig.isDarkTheme() ? const Color(0xff141922) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                initValue: title,
                onChangedFunction: (value) {
                  title = value;
                },
                hintText: "This is title",
                validationMessage:
                    AppLocalizations.of(context)!.task_title_validation,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                initValue: description,
                onChangedFunction: (value) {
                  description = value;
                },
                hintText: "This is description",
                validationMessage:
                    AppLocalizations.of(context)!.task_description_validation,
                maxLines: 4,
              ),
              const SizedBox(
                height: 24,
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
                DateFormat.yMd().format(currentDate),
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
                        horizontal: 50,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      MyTheme.primaryColor,
                    ),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.taskModel.title = title;
                    widget.taskModel.description = description;
                    widget.taskModel.dateTime = currentDate;
                    updateTask(
                      id: widget.taskModel.id!,
                      task: widget.taskModel,
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.save_changes,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showCursomDatePicker() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate == null) {
      return;
    }
    setState(() {});
    currentDate = chosenDate;
  }

  Future<void> updateTask({required String id, required TaskModel task}) async {
    listsProvider.updateTask(id, task).timeout(
      const Duration(milliseconds: 100),
      onTimeout: () {
        listsProvider
            .getAllTasks()
            .timeout(const Duration(milliseconds: 100), onTimeout: () {});
      },
    );

    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: AppLocalizations.of(context)!.edit_message,
      ),
    );
    Navigator.of(context).pop();
  }
}
