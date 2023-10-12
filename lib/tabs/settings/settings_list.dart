import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings/language_section.dart';
import 'package:todo_app/tabs/settings/theme_section.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          LanguageSection(),
          SizedBox(
            height: 24,
          ),
          ThemeSection(),
        ],
      ),
    );
  }
}
