import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/screens/home/build_floating_action_button.dart';
import 'package:todo_app/screens/home/widgets/add_task.dart';
import 'package:todo_app/tabs/settings/settings_list.dart';
import 'package:todo_app/tabs/taks_list/tasks_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const TasksTab(),
    const SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 0
              ? AppLocalizations.of(context)!.to_do_list
              : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: currentIndex == 0
          ? createFloatingActionButton(
              appConfig: appConfig, onPressedFunction: showAddBottomSheet)
          : null,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          appConfig.isDarkTheme()
              ? const BoxShadow()
              : BoxShadow(
                  color: MyTheme.gradientColor.withOpacity(0.35),
                  blurRadius: 7,
                )
        ]),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          backgroundColor:
              appConfig.isDarkTheme() ? const Color(0xff141922) : MyTheme.whiteColor,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.format_list_bulleted,
                ),
                label: AppLocalizations.of(context)!.to_do),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
      ),
    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddTaskWidget(),
      ),
    );
  }
}
