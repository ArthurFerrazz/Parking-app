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
            Image.asset(
              'assets/images/ferrari.jpg',
              width: MediaQuery.of(context).size.width * 0.5,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                      ),
                      width: 350,
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Digite seu e-mail',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                      ),
                      width: 350,
                      child: const TextField(
                          decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (() {
                          Navigator.pushReplacementNamed(context, 'home');
                        }),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.car_rental),
                            Text('Acessar'),
                          ],
                        )),
                  )
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
