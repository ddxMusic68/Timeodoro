import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/json.dart';
import 'package:timodoro/main.dart';
import '../timer.dart';

class RestPage extends StatelessWidget {
  const RestPage({super.key});

  Future<int> loadRestTime() async {
    final settings = await loadSettings();
    return settings["rest_time"] ?? 5;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: loadRestTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final restTime = snapshot.data!;
          return Consumer<CurrentIndex>(
            builder: (context, currentIndex, child) {
              return Center(
                child: CountdownTimerWidget(
                  timer: CountdownTimer(
                    duration: Duration(minutes: restTime),
                    onComplete: () {
                      currentIndex.next();
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
