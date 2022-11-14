import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onequiz/services.dart/database.dart';

import '../models/test.dart';

 late Test test;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _link = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text("OneQuiz"),
        centerTitle: true,
      ),
      body: LinkBox(_link, context),
    );
  }
}

Widget LinkBox(_link, context) {
  return Center(
    child: ListView(shrinkWrap: true, children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _link,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Code'),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: () async {
          if (_link.text.length == 5) {
            CoolAlert.show(context: context, type: CoolAlertType.loading);
            var result = await processTestCode(_link.text);
            Navigator.pop(context);
            if (result is bool) {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: "Invalid Test code");
            } else {
              if (test.isOpen == 1) {
                DatabaseService _dbService = DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid);
                if (await _dbService
                    .checkAttendedStatus(test.scoreBoardCollectionId)) {
                  Navigator.pushReplacementNamed(context, '/quiz', arguments: {
                    'questions': result,
                    'sid': test.scoreBoardCollectionId
                  });
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text:
                          "you alredy attended the test contact admin ${test.contactMail}");
                }
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    text: "test is closed");
              }
            }
          } else {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                text: "please enter valid test code");
          }
        },
        child: const Text("Take Test"),
      )
    ]),
  );
}

Future<dynamic> processTestCode(String testId) async {
  DatabaseService _dbService =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  var testc = await _dbService.getTestMetaData(testId);
  if (testc == null) return false;
  test = testc ;
  var qlist = await _dbService.getQuestions(test);
  if (qlist == null) return false;
  return qlist;
}
