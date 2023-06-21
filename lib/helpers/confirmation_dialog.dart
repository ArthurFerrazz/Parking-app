import 'package:flutter/material.dart';
import 'package:teste/main.dart';

confirmationDialog({required Function() function, String title = 'Sucesso', String content = 'Deu certo!'}) {
  return showDialog(
      context: navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            height: 100,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 145, 84, 1),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          content: Text(
              content,
              textAlign: TextAlign.center,
              style:
              Theme.of(context).textTheme.bodyLarge),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(170, 40),
                  backgroundColor: const Color.fromRGBO(25, 145, 84, 1),),
                onPressed: () {
                  function();
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      });
}