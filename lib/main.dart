import 'package:flutter/material.dart';
import 'package:teste/screens/add_estacionamento_screen/add_estacionamento.dart';
import 'package:teste/screens/editar_estacionamento_screen/editar_estacionamento.dart';
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
          platform: TargetPlatform.windows,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(11, 22, 65, 1)),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Color.fromRGBO(255, 237, 214, 1),
              fontSize: 40
            ),
            labelLarge: TextStyle(
              color: Color.fromRGBO(255, 237, 214, 1)
            )
          ),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(255, 237, 214, 1),
            size: 40
          ),
        ),
        routes: {
          "login": (context) => const LoginScreen(),
          "home": (context) => const HomeScreen(),
          "add_estacionamento": (context) => const AdicionarEstacionamento(),
        },
        initialRoute: "login",
        onGenerateRoute: (settings) {
          if(settings.name == 'editar_estacionamento') {
            Map<String, dynamic> routeArgs = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context) {
              return EditarEstacionamento(
                id: routeArgs['id'],
                nome: routeArgs['nome'],
                cnpj: routeArgs['cnpj'],
                endereco: routeArgs['endereco'],
                qtdVagas: routeArgs['qtdVagas'],
                preco: routeArgs['preco'],
                telefone: routeArgs['telefone'],
                cep: routeArgs['cep'],
                diaDoVencimento: routeArgs['diaDoVencimento'],
                isActive: routeArgs['isActive'],
              );
            });
          }
        },
        );
  }
}
