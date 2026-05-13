import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timodoro/pages/work.dart';
import 'package:timodoro/pages/rest.dart';
import 'package:timodoro/pages/settings.dart';
import 'package:timodoro/pages/notes.dart';

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
              WorkPage(),
              RestPage(),
              NotesPage(),
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
                currentIndex.setIndex(2);
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

