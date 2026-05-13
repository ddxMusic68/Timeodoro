import 'package:flutter/material.dart';
import '../timer.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 4),
          onComplete: () {
          print('text');
        })),
      ),
    );
  }
}