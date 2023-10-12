import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  appConfig.changeThemeMode("light");
                },
                child: !appConfig.isDarkTheme()
                    ? getSelectedItemWidget(AppLocalizations.of(context)!.light)
                    : getUnselectedItemWidget(
                        AppLocalizations.of(context)!.light)),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                appConfig.changeThemeMode("dark");
              },
              child: appConfig.isDarkTheme()
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnselectedItemWidget(AppLocalizations.of(context)!.dark),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String currentThemeMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentThemeMode,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                // color: kPrimaryLightColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Icon(
          Icons.check,
          // color: kPrimaryLightColor,
          size: 32,
        )
      ],
    );
  }

  Widget getUnselectedItemWidget(String currentThemeMode) {
    return Text(currentThemeMode,
        style: Theme.of(context).textTheme.titleSmall);
  }
}
