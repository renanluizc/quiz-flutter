import 'dart:convert';

class Question {
  String question;
  String answer1;
  String answer2;

  Question({
    this.question,
    this.answer1,
    this.answer2,
  });

  Question copyWith({
    String question,
    String answer1,
    String answer2,
  }) {
    return Question(
      question: question ?? this.question,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
    };
  }

  static Question fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Question(
      question: map['question'],
      answer1: map['answer1'],
      answer2: map['answer2'],
    );
  }

  String toJson() => json.encode(toMap());

  static Question fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Question(question: $question, answer1: $answer1, answer2: $answer2)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Question &&
        o.question == question &&
        o.answer1 == answer1 &&
        o.answer2 == answer2;
  }

  @override
  int get hashCode => question.hashCode ^ answer1.hashCode ^ answer2.hashCode;
}
