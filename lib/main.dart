import 'package:flutter/material.dart';
import 'package:quizz_app/quizz_helper.dart';
import './question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: const Text("Quiz App"),
          centerTitle: true,
        ),
        body: const quizPage(),
      ),
    );
  }
}

class quizPage extends StatefulWidget {
  const quizPage({Key? key}) : super(key: key);

  @override
  State<quizPage> createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  bool buttonState = true;
  int questionIndex = 0;
  int rightAnswers = 0;
  List<Icon> trackAnswer = [];
  QuizzHelper quizHelper = QuizzHelper();

  void checkAnswer(bool userAnswer) {
    setState(() {
      int questionsNo = quizHelper.getQuestionsNo();

      if (quizHelper.getQuestionAnswer(questionIndex) == userAnswer) {
        trackAnswer.add(const Icon(
          Icons.check,
          color: Colors.green,
          size: 35.0,
        ));
        rightAnswers++;
      } else {
        trackAnswer.add(const Icon(
          Icons.close,
          color: Colors.red,
          size: 35.0,
        ));
      }

      if (questionIndex == questionsNo - 1) {
        buttonState = false;
        resetQuiz();
      } else {
        if (questionIndex < questionsNo - 1) {
          questionIndex++;
        }
      }
    });
  }

  void resetQuiz() async {
    await Future.delayed(const Duration(seconds: 2));
    Alert(
      context: context,
      title: "Quiz App",
      desc: "End of questions! "
          "\n Right answers : $rightAnswers "
          "\n Wrong answers : ${quizHelper.getQuestionsNo() - rightAnswers}",
    ).show();
    buttonState = true;
    questionIndex = 0;
    rightAnswers = 0;
    trackAnswer.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              quizHelper.getQuestionText(questionIndex),
              style: const TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quizHelper.getTextForQuestionsTrack(questionIndex),
              style: const TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: buttonState
                  ? () {
                      checkAnswer(true);
                    }
                  : null,
              child: const Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: buttonState
                  ? () {
                      checkAnswer(false);
                    }
                  : null,
              child: const Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: trackAnswer,
          ),
        )
      ],
    );
  }
}
