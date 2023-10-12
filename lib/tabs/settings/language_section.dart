import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/tabs/settings/language_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    var appConfig = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            showLanguageBottomSheet(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: appConfig.isDarkTheme() ? const Color(0xff141922) : Colors.white,
              border: Border.all(color: MyTheme.primaryColor, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appConfig.appLanguage == "en"
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: TextStyle(
                    fontSize: 14,
                    color: MyTheme.primaryColor,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: MyTheme.primaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void showLanguageBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const LanguageBottomSheet();
      },
    );
  }
}
