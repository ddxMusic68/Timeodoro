import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timodoro/main.dart';
import '../timer.dart';

class RestPage extends StatelessWidget {
  const RestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndex> (
      builder: (context, currentIndex, child) {
      return Center(
        child: CountdownTimerWidget(timer: 
        CountdownTimer(
          duration: Duration(seconds: 2),
          onComplete: () {
            currentIndex.next();
          }
        )),
      );
      }
    );
  }
}