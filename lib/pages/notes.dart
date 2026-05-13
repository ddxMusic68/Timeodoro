import 'package:flutter/material.dart';
import '../timer.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 1),
          onComplete: () {
          print('text');
        })),
      ),
    );
  }
}