import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
                appConfig.changeLanguage("en");
              },
              child: appConfig.appLanguage == "en"
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                  : getUnselectedItemWidget(
                      AppLocalizations.of(context)!.english),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  appConfig.changeLanguage("ar");
                },
                child: appConfig.appLanguage == "ar"
                    ? getSelectedItemWidget(
                        AppLocalizations.of(context)!.arabic)
                    : getUnselectedItemWidget(
                        AppLocalizations.of(context)!.arabic)),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
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

  Widget getUnselectedItemWidget(String language) {
    return Text(language, style: Theme.of(context).textTheme.titleSmall);
  }
}
