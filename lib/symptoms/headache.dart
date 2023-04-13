import 'package:flutter/material.dart';

class Headache extends StatelessWidget {
  const Headache({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('About Headache..')),
          backgroundColor: Color(0xFF7165D6),
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
                height: 550,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Things to know about Headache',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                          'The common cold is a viral infection of your nose and throat (upper respiratory tract). It\'s usually harmless, although it might not feel that way. Many types of viruses can cause a common cold.'),
                    ),
                    Text(
                        'Healthy adults can expect to have two or three colds each year. Infants and young children may have even more frequent colds.'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Tips to Prevent The Headache',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          '"Many people are very busy and are reluctant to take the time, but if you consider the tradeoff of spending 10 minutes to close the blinds, lie down, and relax when you feel a headache forming, that might be better use of your time than being incapacitated later on after it gets worse," Dr. Loder said.'),
                    ),
                    Text(
                        "To quickly get rid of a headache, one can have some tea, coffee or something with a little caffeine in it. Over-the-counter pain relievers like acetaminophen may also work better.")
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
