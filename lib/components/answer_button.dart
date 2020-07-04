import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_flutter/components/finish_dialog.dart';
import 'package:quiz_flutter/components/result_dialog.dart';
import 'package:quiz_flutter/controllers/quiz_controller.dart';

class AnswerButton extends StatefulWidget {
  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  final _controller = QuizController();
  List<Widget> _scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          var result = _controller.correctAnswer(text);

          setState(() {
            _scoreKeeper.add(
              FaIcon(
                result ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.timesCircle,
                color: result ? Colors.green : Colors.red,
              ),
            );
          });

          ResultDialog.show(
            context,
            question: _controller.question,
            correct: result,
            onNext: () {
              if (_scoreKeeper.length == _controller.questionNumber) {
                FinishDialog.show(
                  context,
                  hitNumber: _controller.hitNumber,
                );
              } else {
                setState(() {
                  _controller.nextQuestion();
                });
              }
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.blue,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}