import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Settings {
  final String theme;
  final String language;
  final bool notifications;
  final int defaultTimerMinutes;

  Settings({
    required this.theme,
    required this.language,
    required this.notifications,
    required this.defaultTimerMinutes,
  });

  Map<String, dynamic> toJson() => {
    "theme": theme,
    "language": language,
    "notifications": notifications,
    "defaultTimerMinutes": defaultTimerMinutes,
  };

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      theme: json["theme"],
      language: json["language"],
      notifications: json["notifications"],
      defaultTimerMinutes: json["defaultTimerMinutes"],
    );
  }
}

const Map<String, dynamic> defaultSettings = {
  "work": 20,
  "notes": 5,
  "rest": 10,
  "pages": 1
};

Future<File> get _localFile async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/settings.json');
}

Future<Map<String, dynamic>> loadSettings() async {
  try {
    final file = await _localFile;

    if (!await file.exists()) {
      return defaultSettings; // return default settings
    }

    final contents = await file.readAsString();
    return jsonDecode(contents);
  } catch (e) {
    return defaultSettings;
  }
}

Future<void> saveSettings(Map<String, dynamic> json) async {
  final file = await _localFile;

  final jsonString = jsonEncode(json);

  await file.writeAsString(jsonString);
}
