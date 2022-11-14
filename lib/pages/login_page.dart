import 'package:flutter/material.dart';

import '../services.dart/authstate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google SignUp"),
        ),
        body: Center(
          child: IconButton(
            onPressed: (() => AuthService().signInWithGoogle()),
            icon: const Icon(Icons.whatshot),
          ),
        ));
  }
}