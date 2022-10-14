import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("OneQuiz"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _link,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Link'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Take Test"),
          )
        ]),
      ),
    );
  }
}
