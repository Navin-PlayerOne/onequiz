import 'package:flutter/material.dart';
import 'package:onequiz/models/questions_model.dart';
import 'package:onequiz/widgets/quiz.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

Answer answers = Answer();
List<Question> q = [
  Question(
    question_id: 1,
    type: 1,
    cat: 1,
    Questions: "what is Player's Real name",
    options: {"PlayerOne", "Navin", "Parzival", "magneto"},
    answer: {"Navin"},
    ans: -1,
  ),
  Question(
      question_id: 2,
      type: 1,
      cat: 1,
      Questions: "what is Thanos name",
      options: {"PlayerOne", "Navin", "Parzival", "Tanush"},
      answer: {"Tanush"},
      ans: -1),
  Question(
      question_id: 3,
      type: 1,
      cat: 1,
      Questions: "who knows java very well",
      options: {"PlayerOne", "Navin", "mani", "Tanush"},
      answer: {"mani"},
      ans: -1),
  Question(
      question_id: 4,
      type: 1,
      cat: 1,
      Questions:
          "9, SwapBuffersCompleted=8809430884971, DisplayPresentTime=0,Reloaded 1 of 598 libraries in 449ms (compile: 21 ms, reload: 273 ms, reassemble: 107 ms).",
      options: {
        "Mani",
        "Navin",
        "Parzival",
        "Tanush",
        "Tony Stark",
        "BatMan",
        "Elon Musk"
      },
      answer: {"Mani"},
      ans: -1)
];

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[500],
          title: const Text("Sample Quiz"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            //scrollDirection: Axis.vertical,
            itemCount: q.length,
            itemBuilder: (context, index) {
              return Quiz(
                  quest: q.elementAt(index), index: index, answers: answers);
            },
          ),
        ));
  }
}
