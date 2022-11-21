import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/myPets.dart';
// import 'package:flutter_application_2/Statefull.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Pet - Luisa Osorio',
      home: const MyPets(),
    );
  }
}
