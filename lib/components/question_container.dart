import 'package:flutter/material.dart';
import 'package:quiz_flutter/controllers/quiz_controller.dart';

class QuestionContainer extends StatelessWidget {
  final _controller = QuizController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Center(
        child: Text(
          _controller.getQuestion(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.0,
          ),
        ),
      ),
    );
  }
}