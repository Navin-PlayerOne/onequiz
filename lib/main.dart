import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:onequiz/pages/home_page.dart';
import 'package:onequiz/pages/quiz_page.dart';
import 'package:onequiz/pages/result.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic ??
                ColorScheme.fromSeed(
                  brightness: Brightness.light,
                  seedColor: Colors.red,
                ),
          ),
          themeMode: ThemeMode.system,
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic ??
                ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: Colors.black,
                ),
          ),
          routes: {
            '/home': (context) => const HomePage(),
            '/': (context) => const QuizView(),
            '/result': (context) => const Result()
          },
        );
      },
    );
  }
}