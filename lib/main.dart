import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';  

import 'package:timodoro/settings.dart';
import 'package:timodoro/page.dart';

void coverScreen() {
  windowManager.setFullScreen(true);
}

void unCoverScreen() {
  windowManager.setFullScreen(false);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(  
    size: Size(400, 300),  
    center: true,  
    backgroundColor: Colors.transparent,  
    skipTaskbar: false,  
    titleBarStyle: TitleBarStyle.normal,  
  );  

  windowManager.waitUntilReadyToShow(windowOptions, () async {  
    await windowManager.show();  
    await windowManager.focus();  
  });  

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    )
  );
}

class AppState extends ChangeNotifier {
  static const int pages = 3; // 3 main pages (settings page excluded)
  int _index = 0;
  bool isRunning = false;

  int get index => _index;

  void toggleRunning() {
    isRunning = !isRunning;
    notifyListeners();
  }

  void setIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
    handleScreen();
  }

  void next() {
    _index = (_index + 1) % pages; // cycle through 0, 1, 2
    notifyListeners();
    handleScreen();
  }

  void handleScreen() {
    switch(_index) {
      case 0:
        unCoverScreen();
        break;
      case 1:
        coverScreen();
        break;
      case 2:
        coverScreen();
        break;
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => AppState(), 
    child: Consumer<AppState> (
      builder: (context, appState, child) {
        return Scaffold(
          body: IndexedStack(
            index: appState.index,
            children: [
              BasePage(
                title: "Work Time",
                instructions: "Focus on your task",
                timeKey: "work_time",
                defaultTime: 20,
              ),
              BasePage(
                title: "Notes Time",
                instructions: "1. (if coding) push repo to cloud \n2. take notes \n3. write down what you did and log time interval",
                timeKey: "notes_time",
                defaultTime: 5,
              ),
              BasePage(
                title: "Rest Time",
                instructions: "Take a break and go to your room till timer runs out.",
                timeKey: "rest_time",
                defaultTime: 10,
              ),
              SettingsPage(),
            ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            appState.isRunning
                ? SizedBox.shrink()
                : FloatingActionButton(
                    onPressed: () {
                      appState.next();
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                appState.setIndex(3);
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
