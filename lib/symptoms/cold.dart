import 'package:flutter/material.dart';

class Cold extends StatelessWidget {
  const Cold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('About Fever..'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Text("HEllo"),
                Text("HEllo"),
                Text("HEllo"),
                Text("HEllo"),
                Text("HEllo"),
                Text("HEllo"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
