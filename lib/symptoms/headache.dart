import 'package:flutter/material.dart';

class Headache extends StatelessWidget {
  const Headache({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('About Headache..'),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 100,
                child: Image.asset("images/headache.jpg"),
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
                      'Things to know about Headache',
                      style: TextStyle(),
                    ),
                    Text(
                      'Tips to Prevent The Headache',
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
