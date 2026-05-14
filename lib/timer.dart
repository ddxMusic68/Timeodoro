import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

abstract class TimerInterface with ChangeNotifier {
  final Duration duration;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;
  late Duration remainingTime;
  bool isRunning = false;

  TimerInterface({
      required this.duration,
      required this.onComplete,
      required this.onStart
    }) : remainingTime = duration;

  void start();
  void pause();
  void reset();
}

class CountdownTimer extends TimerInterface {
  Timer? _timer;

  CountdownTimer({required super.duration, required super.onComplete, required super.onStart});

  @override
  void start() {
    if (isRunning) return;
    if (onStart != null) onStart!();

    isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 1) {
        remainingTime = Duration.zero;
        reset();
        if (onComplete != null) onComplete!();
      } else {
        remainingTime -= const Duration(seconds: 1);
      }
      notifyListeners(); // tell widgets to rebuild
    });

    notifyListeners();
  }

  @override
  void pause() {
    stopTimer();
    notifyListeners();
  }

  @override
  void reset() {
    stopTimer();
    remainingTime = duration;
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    isRunning = false;
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}

class CountdownTimerWidget extends StatelessWidget {
  final TimerInterface timer;

  const CountdownTimerWidget({super.key, required this.timer});

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerInterface>.value(
      value: timer,
      child: Consumer<TimerInterface>(
        builder: (context, t, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _format(t.remainingTime),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: t.start,
                    child: Text(t.isRunning ? 'Running' : 'Start'),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
