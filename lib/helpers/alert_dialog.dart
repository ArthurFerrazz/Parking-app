import 'package:flutter/material.dart';
import 'package:teste/main.dart';

alertDialog({required Function() function, String title = 'Alerta', String content = 'Algo inesperado aconteceu!'}) {
  return showDialog(
      context: navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .error
                    .withOpacity(0.6),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground,
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
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .highlightColor
                          .withOpacity(0.2),
                      minimumSize: const Size(80, 36),
                      textStyle: const TextStyle(
                          color: Colors.white)),
                  onPressed: () =>
                      Navigator.pop(context, 'Cancelar'),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          color: Colors.white),
                      minimumSize: const Size(80, 36),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .error
                          .withOpacity(0.65)),
                  onPressed: () {
                    function();
                  },
                  child: Text(
                    'Sim',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        );
      });
}