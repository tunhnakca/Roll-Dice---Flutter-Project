import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _toggle = false;
  String title = 'Flutter Demo';
  int _counter = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Awesome'),
        ),
        body: Column(
          children: [
            if (_toggle) const AwesomeWidget(),
            MyHomePage(title: '$_counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter += 1;
                });
              },
              child: const Text('increment'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(
              () {
                _toggle = !_toggle;
              },
            );
          },
          child: const Text('Toggle'),
        ),
      ),
    );
  }
}

class AwesomeWidget extends StatefulWidget {
  const AwesomeWidget({super.key});

  @override
  State<AwesomeWidget> createState() => _AwesomeWidgetState();
}

class _AwesomeWidgetState extends State<AwesomeWidget> {
  @override
  void initState() {
    print('=== AwesomeWidget initState ===');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('=== AwesomeWidget didChangeDependencies ===');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AwesomeWidget oldWidget) {
    print('=== AwesomeWidget didUpdateWidget ===');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('== AwesomeWidget dispose ===');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(45),
      color: const Color.fromARGB(233, 121, 9, 9),
      child: const Center(
        child: Text('Awesome Widget'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    print('=== MyHomePage initState ===');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('=== MyHomePage didChangeDependencies ===');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    print(oldWidget.title);
    print('=== MyHomePage didUpdateWidget ===');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('== MyHomePage dispose ===');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    return Column(
      children: [
        Center(
          child: Text('Counter $title'),
        ),
      ],
    );
  }
}
