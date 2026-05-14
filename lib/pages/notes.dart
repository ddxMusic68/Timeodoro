import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/json.dart';
import 'package:timodoro/main.dart';
import '../timer.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  Future<int> loadNoteTime() async {
    final settings = await loadSettings();
    return settings["note_time"] ?? 5;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: loadNoteTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final noteTime = snapshot.data!;
          return Consumer<CurrentIndex>(
            builder: (context, currentIndex, child) {
              return Center(
                child: CountdownTimerWidget(
                  timer: CountdownTimer(
                    duration: Duration(minutes: noteTime),
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