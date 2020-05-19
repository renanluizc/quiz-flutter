import 'package:quiz_flutter/models/questions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizApi {
  static Future<List<Question>> fetch() async {
    try {
      var url =
          "https://script.google.com/macros/s/AKfycbyhpDQV-1NW70UWkHeC58rt779uiu6WSTWyWyW5OxOjowDT3ihr/exec";
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<Question>.from(
            data["questions"].map((q) => Question.fromMap(q)));
      } else {
        return List<Question>();
      }
    } catch (error) {
      print(error);
      return List<Question>();
    }
  }
}
