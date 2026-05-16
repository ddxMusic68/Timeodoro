import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/json.dart';
import 'package:timodoro/main.dart';
import 'package:timodoro/timer.dart';

class BasePage extends StatelessWidget {
  final String title;
  final String instructions;
  final String timeKey;
  final int defaultTime;

  const BasePage({
    super.key,
    required this.title,
    required this.instructions,
    required this.timeKey,
    required this.defaultTime,
  });

  Future<int> loadTime() async {
    final settings = await loadSettings();
    return settings[timeKey] ?? defaultTime;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: loadTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final restTime = snapshot.data!;
          return Consumer<AppState>(
            builder: (context, appState, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  CountdownTimerWidget(
                    timer: CountdownTimer(
                      duration: Duration(minutes: restTime),
                      onStart: () {
                        // appState.toggleRunning();
                      },
                      onComplete: () {
                        // appState.toggleRunning();
                        appState.next();
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(instructions, style: TextStyle(fontSize: 24)),
                ],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
