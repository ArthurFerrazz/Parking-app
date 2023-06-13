import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TESTE'),
        backgroundColor: Colors.red,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MeuCard(
              cardColor: Colors.grey,
              texto1: 'Primeiro card',
              texto2: 'Primeiro card segundo texto',
            ),
            MeuCard(
              cardColor: Colors.red,
              texto1: 'Segundo card',
              texto2: 'Segundo card segundo texto',
            ),
            MeuCard(
              cardColor: Colors.yellow,
              texto1: 'Terceiro card',
              texto2: 'Terceiro card segundo texto',
            ),
          ],
        ),
      ),
    );
  }
}

class MeuCard extends StatelessWidget {
  final Color cardColor;
  final String texto1;
  final String texto2;
  const MeuCard(
      {super.key,
      required this.cardColor,
      required this.texto1,
      required this.texto2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Card(
        color: cardColor,
        child: Center(
          child: Column(
            children: [
              Text(texto1),
              Text(texto2),
              const Text('TRÊS CARD'),
            ],
          ),
        ),
      ),
    );
  }
}
