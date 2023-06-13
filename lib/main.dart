import 'package:flutter/material.dart';
import 'package:teste/screens/home_screen/home_screen.dart';
import 'package:teste/screens/login_screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Estacionamento',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {"login": (context) => const LoginScreen()},
        home: const LoginScreen());
  }
}
