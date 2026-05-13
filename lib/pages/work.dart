import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/main.dart';
import '../timer.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndex> (
      builder: (context, currentIndex, child) {
      return Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 4),
          onComplete: () {
            currentIndex.next();
          }
        )),
      );
      }
    );
  }
}