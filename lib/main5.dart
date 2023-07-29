import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
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
        child: StarWarsPeople(),
      ),
    );
  }
}

class StarWarsPeople extends StatefulWidget {
  const StarWarsPeople({super.key});

  @override
  State<StarWarsPeople> createState() => _StarWarsPeopleState();
}

class _StarWarsPeopleState extends State<StarWarsPeople> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<dynamic> _fetchData() async {
    Future.delayed(const Duration(seconds: 10));
    final response = await fetchPeople();
    if (response.statusCode == HttpStatus.ok) {
      final body = response.body;
      final parsed = jsonDecode(body);
      final results = parsed['results'] as List<dynamic>;
      return results
          .map(
            (person) => Person.fromJson(person),
          )
          .toList();
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _fetchData,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<dynamic>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ),
              );
            }
            if (snapshot.hasData) {
              return ListOfPeople(people: snapshot.data);
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class ListOfPeople extends StatelessWidget {
  final List<Person> people;
  const ListOfPeople({
    super.key,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => Text(
        '${people[index]} - ${people[index].created}',
        style: const TextStyle(fontSize: 24),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: people.length,
    );
  }
}

class Person {
  String name;
  double height;
  double mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String created;
  DateTime edited;

  Person({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.created,
    required this.edited,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    var formatter = DateFormat.yMEd();
    var date = DateTime.parse(json['created']);
    return Person(
      name: json['name'],
      height: double.parse(json['height']),
      mass: double.parse(json['mass']),
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      created: formatter.format(date),
      edited: DateTime.parse(json['edited']),
    );
  }

  @override
  String toString() {
    return name;
  }
}
