import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/providers/list_provider.dart';
import 'package:todo_app/screens/edit_task/edit_task_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(
      // ChangeNotifierProvider<AppConfigProvider>(
      //   create: (context) {
      //     return AppConfigProvider();
      //   },
      //   child: const TODO(),
      // ),
      MultiProvider(
    providers: [
      ChangeNotifierProvider<AppConfigProvider>(
        create: (context) {
          return AppConfigProvider();
        },
      ),
      ChangeNotifierProvider<ListsProvider>(
        create: (context) {
          return ListsProvider();
        },
      ),
    ],
    child: const TODO(),
  ));
}

class TODO extends StatelessWidget {
  const TODO({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: appConfig.isDarkTheme() ? ThemeMode.dark : ThemeMode.light,
      // themeMode: ThemeMode.light,
      initialRoute: HomeScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appConfig.appLanguage),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
      },
    );
  }
}
