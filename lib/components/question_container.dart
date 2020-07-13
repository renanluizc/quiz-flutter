import 'package:flutter/material.dart';

class QuestionContainer extends StatelessWidget {
  final String question;

  QuestionContainer(
    this.question,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          question,
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