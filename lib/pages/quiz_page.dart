import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_flutter/components/answer_button.dart';
import 'package:quiz_flutter/components/centered_circular_progress.dart';
import 'package:quiz_flutter/components/centered_message.dart';
import 'package:quiz_flutter/components/question_container.dart';
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
        QuestionContainer(),
        AnswerButton(_controller.getAnswer1()),
        SizedBox(
          height: 8.0,
        ),
        AnswerButton(_controller.getAnswer2()),
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
}
