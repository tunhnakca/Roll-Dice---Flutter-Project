import 'dart:convert';
import 'dart:io';

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
  List<Person> starWarsCharacters = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future _fetchData() async {
    final response = await fetchPeople();
    if (response.statusCode == HttpStatus.ok) {
      final body = response.body;
      final parsed = jsonDecode(body);
      final results = parsed['results'] as List<dynamic>;
      final people = results
          .map(
            (person) => Person.fromJson(person),
          )
          .toList();
      setState(() {
        starWarsCharacters = people;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchData,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: (context, index) => Text(
            '${starWarsCharacters[index]}',
            style: const TextStyle(fontSize: 24),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: starWarsCharacters.length,
        ),
      ),
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
  DateTime created;
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
    return Person(
      name: json['name'],
      height: double.parse(json['height']),
      mass: double.parse(json['mass']),
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      created: DateTime.parse(json['created']),
      edited: DateTime.parse(json['edited']),
    );
  }

  @override
  String toString() {
    return '$name ${created.year}';
  }
}
