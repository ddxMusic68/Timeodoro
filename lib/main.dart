import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timodoro/settings.dart';
import 'package:timodoro/page.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApp(),
    )
  );
}

class CurrentIndex extends ChangeNotifier {
  int _index = 0;
  final int pages;

  CurrentIndex({required this.pages});

  int get index => _index;

  void setIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }

  void next() {
    _index = (_index + 1) % pages; // cycle through 0, 1, 2
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  final CurrentIndex currentIndex = CurrentIndex(pages: 3);

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => CurrentIndex(pages: 3), 
    child: Consumer<CurrentIndex> (
      builder: (context, currentIndex, child) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex.index,
            children: [
              BasePage(
                title: "Work Time",
                instructions: "Focus on your task until the timer runs out.",
                timeKey: "work_time",
                defaultTime: 20,
              ),
              BasePage(
                title: "Notes Time",
                instructions: "Write down any thoughts or ideas you have.",
                timeKey: "notes_time",
                defaultTime: 5,
              ),
              BasePage(
                title: "Rest Time",
                instructions: "Take a break and relax until the timer runs out.",
                timeKey: "rest_time",
                defaultTime: 10,
              ),
              SettingsPage(),
            ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                currentIndex.next();
              },
              child: Icon(Icons.arrow_forward),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                currentIndex.setIndex(3);
              },
              child: Icon(Icons.settings),
            )
          ],
        ),
      );
      }
    )
    );
  }
}

