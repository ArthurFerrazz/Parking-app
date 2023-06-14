import 'package:flutter/material.dart';
import 'package:teste/screens/add_estacionamento_screen/add_estacionamento.dart';
import 'package:teste/screens/home_screen/home_screen.dart';
import 'package:teste/screens/login_screen/login_screen.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Estacionamento',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          "login": (context) => const LoginScreen(),
          "home": (context) => const HomeScreen(),
          "add_estacionamento": (context) => const AdicionarEstacionamento()
        },
        home: const LoginScreen());
  }
}
