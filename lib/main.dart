import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: App(),
    ),
  );
}

Future<http.Response> fetchPeople() async {
  final uri = Uri.parse('https://swapi.dev/api/people');
  return await http.get(uri);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MyContactForm(),
      ),
    );
  }
}

class MyContactForm extends StatefulWidget {
  const MyContactForm({super.key});

  @override
  State<MyContactForm> createState() => _MyContactFormState();
}

class _MyContactFormState extends State<MyContactForm> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // ..addListener(() {
    //   print(_nameController.text);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            keyboardAppearance: Brightness.dark,
            // enabled: false,
            onEditingComplete: () {
              print(_nameController.text);
            },
            obscuringCharacter: '#',
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
            ),
            controller: _nameController,
          ),
          ElevatedButton(
            onPressed: () {
              print(_nameController.text);
            },
            child: const Text('Submit'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
