import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/questions_model.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<Answer> answers = [];
  List<Question> questios = [];
  Map<String, dynamic> hashes = {};
  Map<String, double> dataMap = {};
  @override
  void initState() {
    //getResult();
    super.initState();
  }

  void getResult() async {
    answers = hashes['result']!;
    questios = hashes['question']!;
    double totoalQuestion = questios.length + 0.0;
    double notAttended = (totoalQuestion - Answer.mp.length);
    double accepted = 0.0;
    for (var key in Answer.mp.keys) {
      if (Answer.mp[key]!) {
        accepted++;
      }
    }
    dataMap = {
      "Wrong": totoalQuestion - accepted,
      "Not Attended": notAttended,
      "Accepted": accepted,
    };
  }

  @override
  Widget build(BuildContext context) {
    hashes = ModalRoute.of(context)!.settings.arguments
        as Map<String, List<dynamic>>;
    getResult();
    print(answers);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text("Result"),
      ),
      body: PieChart(
        dataMap: dataMap,
        colorList: [Colors.red, Colors.blue, Colors.green],
      ),
    );
  }
}
