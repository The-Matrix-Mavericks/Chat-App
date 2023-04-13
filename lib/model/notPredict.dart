import 'package:chat/Schedule/reschedule.dart';
import 'package:flutter/material.dart';

import '../form/visitclinic.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Disease Prediction"),
          ),
        ),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'We are not able to predict the disease',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("You have Severe symptoms of the disease"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClinicVisitForm()),
                    );
                  },
                  child: Text("Get Instant Checkup"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
