import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../json.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController pages = TextEditingController();
  final TextEditingController workTime = TextEditingController();
  final TextEditingController restTime = TextEditingController();
  final TextEditingController notesTime = TextEditingController();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) { 
    return Column (
        children: [
          TextField(
            controller: pages,
            decoration: InputDecoration(
              labelText: 'Work Time (minutes)',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            controller: restTime,
            decoration: InputDecoration(
              labelText: 'Rest Time (minutes)',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            controller: notesTime,
            decoration: InputDecoration(
              labelText: 'Notes Time (minutes)',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          ElevatedButton(
            onPressed: () {
              saveSettings({
                "screens": int.parse(pages.text),
                "work_time": int.parse(workTime.text),
                "rest_time": int.parse(restTime.text),
                "notes_time": int.parse(notesTime.text),
              });
            },
            child: Text('Save Settings'),
          )
        ]
      );
  }
}