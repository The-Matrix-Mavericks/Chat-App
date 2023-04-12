import 'package:flutter/material.dart';

class Cough extends StatelessWidget {
  const Cough({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('About Cough..'),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 100,
                child: Image.asset("images/cough.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Things to know about Cough',
                      style: TextStyle(),
                    ),
                    Text(
                      'Tips to Prevent The Cough',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
