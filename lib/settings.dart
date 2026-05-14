import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'json.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController pages = TextEditingController();
  final TextEditingController workTime = TextEditingController();
  final TextEditingController restTime = TextEditingController();
  final TextEditingController notesTime = TextEditingController();

  @override
  void dispose() {
    pages.dispose();
    workTime.dispose();
    restTime.dispose();
    notesTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Column (
      
        children: [
          TextField(
            controller: pages,
            decoration: InputDecoration(
              labelText: 'pages',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          TextField(
            controller: workTime,
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
                "screens": int.tryParse(pages.text) ?? 1,
                "work_time": int.tryParse(workTime.text) ?? 20,
                "rest_time": int.tryParse(restTime.text) ?? 10,
                "notes_time": int.tryParse(notesTime.text) ?? 5,
              });
            },
            child: Text('Save Settings'),
          )
        ]
      );
  }
}