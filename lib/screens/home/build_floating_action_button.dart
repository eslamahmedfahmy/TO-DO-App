import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

Container createFloatingActionButton(
    {required AppConfigProvider appConfig,
    required void Function() onPressedFunction}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
      appConfig.isDarkTheme()
          ? const BoxShadow()
          : BoxShadow(
              color: MyTheme.gradientColor.withOpacity(0.35),
              blurRadius: 7,
            )
    ]),
    child: FloatingActionButton(
      backgroundColor: MyTheme.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
            color: appConfig.isDarkTheme()
                ? const Color(0xff141922)
                : MyTheme.whiteColor,
            width: 5),
      ),
      onPressed: onPressedFunction,
      child: Icon(
        Icons.add,
        color: MyTheme.whiteColor,
        size: 28,
      ),
    ),
  );
}
