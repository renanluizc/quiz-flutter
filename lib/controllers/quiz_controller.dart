import 'dart:math';
import 'package:quiz_flutter/models/questions.dart';
import 'package:quiz_flutter/services/quiz_api.dart';

class QuizController {
  List<Question> _questionBank;
  int questionIndex = 0;
  int hitNumber = 0;
  bool _shiftAnswer;
  Random _random = Random();

  int get questionNumber => _questionBank?.length ?? 0;
  Question get question => _questionBank[questionIndex];

  Future<void> initialize() async {
    questionIndex = 0;
    hitNumber = 0;
    _questionBank = await QuizApi.fetch();
    _questionBank.shuffle();
    _shiftAnswer = _random.nextBool();
  }

  String getQuestion() {
    return _questionBank[questionIndex].question;
  }

  String getAnswer1() {
    return _shiftAnswer ? question.answer1 : question.answer2;
  }

  String getAnswer2() {
    return _shiftAnswer ? question.answer2 : question.answer1;
  }

  bool correctAnswer(String answer) {
    var correct = question.answer1 == answer;
    hitNumber = hitNumber + (correct ? 1 : 0);
    return correct;
  }

  void nextQuestion() {
    questionIndex++;
    _shiftAnswer = _random.nextBool();
  }
}
