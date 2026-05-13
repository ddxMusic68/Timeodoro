import 'package:flutter/material.dart';
import '../timer.dart';

class RestPage extends StatelessWidget {
  const RestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 2),
          onComplete: () {
          print('text');
        })),
      ),
    );
  }
}