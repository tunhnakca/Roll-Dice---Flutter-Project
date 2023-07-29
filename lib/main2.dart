import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: App(),
    ),
  );
}

final List<String> todos = List.generate(100, (index) => 'Todo $index');

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemBuilder: (BuildContext context, index) => Text(todos[index]),
              separatorBuilder: (BuildContext context, index) => const Divider(
                color: Colors.red,
                height: 45,
              ),
              itemCount: todos.length,
            ),
            // child: ListView.builder(
            //   itemCount: todos.length,
            //   itemBuilder: (BuildContext context, index) {
            //     return Text(todos[index]);
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
