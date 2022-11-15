import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onequiz/models/questions_model.dart';
import 'package:onequiz/services.dart/database.dart';
import 'package:onequiz/widgets/quiz.dart';
import 'package:provider/provider.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

int index = 0;

PageController _controller = PageController();
List<Answer> answers = [];
List<Question> questions = [];
Map<String, dynamic> hashes = {};
String scoreBoardId = "";
String testId = "";

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    hashes = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setValues(hashes['questions']!);
    scoreBoardId = hashes['sid']!;
    testId = hashes['testId']!;
    return StreamProvider<bool>.value(
      value: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .getStatus(testId),
      initialData: false,
      child: Parser(),
    );
  }

  void setValues(List<Question> questin) {
    setState(() {
      questions = questin;
      for (int i = 0; i < questin.length; i++) {
        answers.add(Answer());
      }
    });
  }
}

class Parser extends StatelessWidget {
  const Parser({super.key});

  @override
  Widget build(BuildContext context) {
    bool status = Provider.of<bool>(context);
    return status
        ? const Scaffold(
            body: Center(
              child: Text("Test is Not Avilable"),
            ),
          )
        : const QuestionsDirective();
  }
}

class QuestionsDirective extends StatelessWidget {
  const QuestionsDirective({
    Key? key,
  }) : super(key: key);

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
                      arguments: {
                        'result': answers,
                        'question': questions,
                        'sid': scoreBoardId
                      });
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
            itemCount: questions.length,
            itemBuilder: (context, index) {
              index = index;
              return Quiz(
                  quest: questions.elementAt(index),
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
