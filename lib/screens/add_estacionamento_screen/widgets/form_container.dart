import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final double width;
  final Widget child;
  final String label;

  const FormContainer({
    Key? key,
    required this.width,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(11, 22, 65, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            width: width,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.5,
                color: Colors.grey,
              ),
            ),
            child: child)
      ],
    );
  }
}