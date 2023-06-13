import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: double.infinity,
              child: Image.asset(
                'assets/images/ferrari.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Digite seu e-mail'),
                  ),
                ),
                const SizedBox(
                  width: 250,
                  child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Digite sua senha')),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40)),
                      onPressed: (() {}),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.car_crash),
                          Text('Acessar'),
                        ],
                      )),
                )
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
