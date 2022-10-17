import 'package:flutter/material.dart';
import 'package:onequiz/models/questions_model.dart';
import 'package:onequiz/widgets/quiz.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

int index = 0;

PageController _controller = PageController();
List<Answer> answers = [Answer(), Answer(), Answer(), Answer()];
List<Question> q = [
  Question(
    question_id: 1,
    type: 1,
    cat: 1,
    Questions: "what is Player's Real name",
    options: {"PlayerOne", "Navin", "Parzival", "magneto"},
    answer: {"Navin"},
  ),
  Question(
    question_id: 2,
    type: 1,
    cat: 1,
    Questions: "what is Thanos name",
    options: {"PlayerOne", "Navin", "Parzival", "Tanush"},
    answer: {"Tanush"},
  ),
  Question(
    question_id: 3,
    type: 2,
    cat: 1,
    Questions: "who knows java very well",
    options: {"PlayerOne", "Navin", "mani", "Tanush"},
    answer: {"mani", "PlayerOne"},
  ),
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
  )
];

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text("Sample Quiz"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/result',
                      arguments: {'result': answers,'question' : q});
                },
                color: Colors.red[400],
                child: const Text("End Test"),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            //scrollDirection: Axis.vertical,
            controller: _controller,
            itemCount: q.length,
            itemBuilder: (context, index) {
              index = index;
              return Quiz(
                  quest: q.elementAt(index),
                  index: index,
                  answers: answers.elementAt(index));
            },
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                child: MaterialButton(
                  onPressed: previousPage,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text("Previous"),
                ),
              ),
              SizedBox(
                width: 150,
                child: MaterialButton(
                  onPressed: () {
                    nextPage();
                  },
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ));
  }
}

void nextPage() {
  _controller.animateToPage(_controller.page!.toInt() + 1,
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
}

void previousPage() {
  _controller.animateToPage(_controller.page!.toInt() - 1,
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
}
