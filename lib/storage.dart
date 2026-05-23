import 'package:flutter/material.dart';

// example of json data structure
// [
//   {
//     "datetime": "2024-06-01T12:00:00Z",
//     "goal": "Read 20 pages",
//     "notes": "Focus on chapter 3",
//   }
// ]

class GoalInput extends StatefulWidget {
  const GoalInput({super.key});

  @override
  State<GoalInput> createState() => _GoalInputState();
}

class _GoalInputState extends State<GoalInput> {
  final TextEditingController goalController = TextEditingController();

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: goalController,
          decoration: InputDecoration(
            labelText: 'Goal',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // save goal to json file
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}