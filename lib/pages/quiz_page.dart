import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_flutter/components/centered_circular_progress.dart';
import 'package:quiz_flutter/components/centered_message.dart';
import 'package:quiz_flutter/components/finish_dialog.dart';
import 'package:quiz_flutter/components/result_dialog.dart';
import 'package:quiz_flutter/controllers/quiz_controller.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = QuizController();
  bool _loading = true;
  List<Widget> _scoreKeeper = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
            'Quiz ${_controller.hitNumber} / ${_controller.questionNumber}'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) {
      return CenteredCircularProgress();
    }

    if (_controller.questionNumber == 0) {
      return CenteredMessage(
        'Sem questões',
        icon: FontAwesomeIcons.exclamationTriangle
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildQuestion(_controller.getQuestion()),
        _buildAnswerButton(_controller.getAnswer1()),
        SizedBox(
          height: 8.0,
        ),
        _buildAnswerButton(_controller.getAnswer2()),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildScoreKeeper() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _scoreKeeper,
      ),
    );
  }

  _buildQuestion(String text) {
    return Expanded(
      flex: 5,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.0,
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(String text) {
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
