import 'package:flutter/material.dart';
import 'package:onequiz/pages/home_page.dart';
import 'package:onequiz/pages/quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OneQuiz',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const QuizView());
  }
}
