import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/main.dart';
import '../timer.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndex> (
      builder: (context, currentIndex, child) {
      return Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 1),
          onComplete: () {
            currentIndex.next();
          }
        )),
      );
      }
    );
  }
}