import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onequiz/services.dart/database.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/questions_model.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

var scores;
int ismore = 0;
bool isLoading = true;

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

  double getResult() {
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
    print("debug");
    return accepted;
  }

  @override
  Widget build(BuildContext context) {
    hashes = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    scores = getResult();
    if (ismore == 0) {
      storResult(scores, hashes['sid']);
    }
    ismore++;
    print("just ");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text("Result"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PieChart(
              dataMap: dataMap,
              colorList: const [Colors.red, Colors.blue, Colors.green],
            ),
    );
  }

  void storResult(scores, sid) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .storeScores(scores, sid);
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .saveTestDetails();
    setState(() {
      isLoading = false;
    });
  }
}
