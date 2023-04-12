import 'package:flutter/material.dart';

class ExampleCard extends StatelessWidget {
  // const ExampleCard({super.key});
  final String candidate;
  ExampleCard({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            candidate,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      color: Colors.deepPurple.shade300,
    );
  }
}
