import 'package:flutter/material.dart';
import 'package:onequiz/pages/quiz_page.dart';
import '../models/questions_model.dart';

class Quiz extends StatefulWidget {
  final Question quest;
  final int index;
  final Answer answers;
  const Quiz(
      {super.key,
      required this.quest,
      required this.index,
      required this.answers});

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
        Options(quest: widget.quest, answers: answers),
      ],
    );
  }
}

class Options extends StatefulWidget {
  final Question quest;
  final Answer answers;
  const Options({super.key, required this.quest, required this.answers});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    print("child build");
    //print(ontap);
    return ListView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.quest.options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (widget.quest.type == 1) {
                widget.answers.mp.addEntries({
                  widget.quest.question_id: singleSelect(widget.quest, index)
                }.entries);
              } else {
                widget.answers.mp.addEntries({
                  widget.quest.question_id: multiSelect(widget.quest, index)
                }.entries);
              }
              print(widget.answers.mp);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.quest.ans.contains(index)
                  ? Colors.green
                  : Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(widget.quest.options.elementAt(index)),
              leading: Text("${index + 1}"),
              trailing: !widget.quest.ans.contains(index)
                  ? null
                  : const Icon(Icons.auto_awesome),
            ),
          ),
        );
      },
    );
  }

  bool singleSelect(Question q, int index) {
    print("Single Selct");
    if (q.ans.contains(index)) {
      q.ans.clear();
    } else {
      q.ans.add(index);
    }
    if (q.ans.isNotEmpty) {
      q.ans.clear();
      q.ans.add(index);
    }
    if (q.ans.isNotEmpty &&
        q.answer.contains(q.options.elementAt(q.ans.first))) {
      return true;
    } else {
      return false;
    }
  }

  bool multiSelect(Question q, int index) {
    print("Multi Selct");
    if (q.ans.contains(index)) {
      q.ans.remove(index);
    } else {
      q.ans.add(index);
    }
    List<String> tmp = [];
    for (var element in q.ans) {
      tmp.add(q.options.elementAt(element));
    }
    if (tmp.length == q.answer.length && q.answer.containsAll(tmp)) {
      return true;
    } else {
      return false;
    }
  }
}

// print(widget.quest.options.elementAt(index));
//               print(widget.quest.answer);
//               if (widget.quest.answer
//                   .contains(widget.quest.options.elementAt(index))) {
//                 widget.answers.mp
//                     .addEntries({widget.quest.question_id: true}.entries);
//               } else {
//                 widget.answers.mp
//                     .addEntries({widget.quest.question_id: true}.entries);
//               }
//               if (widget.quest.ans == index) {
//                 widget.quest.ans = -1;
//               } else {
//                 widget.quest.ans = index;
//               }
//               print(widget.answers.mp);