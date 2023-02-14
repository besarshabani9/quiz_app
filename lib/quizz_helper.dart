import './question.dart';

class QuizzHelper {
  final List<Question> _questions = [
    Question(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
        true),
    Question(
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s?",
        false),
    Question("It has survived not only five centuries?", false),
    Question(
        "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum?",
        true),
    Question(
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout?",
        true),
  ];

  String getQuestionText(int questionIndex) {
    return _questions[questionIndex].questionText;
  }

  bool getQuestionAnswer(int questionIndex) {
    return _questions[questionIndex].questionAnswer;
  }

  String getTextForQuestionsTrack(int questionIndex) {
    return "${questionIndex + 1} / ${_questions.length}";
  }

  int getQuestionsNo() {
    return _questions.length;
  }
}
