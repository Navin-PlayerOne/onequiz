import 'package:flutter/material.dart';
import '../models/questions_model.dart';

class Quiz extends StatefulWidget {
  final Question quest;
  final int index;
  const Quiz({super.key, required this.quest, required this.index});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Text("Question : ${widget.index + 1}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 5.0),
        Text(widget.quest.Questions,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        const SizedBox(height: 10.0),
        Options(quest: widget.quest),
      ],
    );
  }
}

class Options extends StatefulWidget {
  final Question quest;
  const Options({super.key, required this.quest});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    print("child build");
    return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.quest.options.length,
      itemBuilder: (context, index) {
        bool ontap = false;
        return Container(
          decoration: const BoxDecoration(
            color: false ? Colors.green : Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(widget.quest.options.elementAt(index)),
            leading: Text("${index + 1}"),
            trailing: !ontap ? null : Icon(Icons.auto_awesome),
          ),
        );
      },
    );
  }
}
