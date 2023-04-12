import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});

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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Text(
                'Fever',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 100,
                child: Image.asset("images/fever.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 500,
                // width: 100,
                child: Column(
                  children: [
                    Text(
                      'know about Fever',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          '"About half of people with glandular fever get a swollen spleen, while one in 750 will end up in hospital with a ruptured (burst) spleen," says Read. "For this reason, people are advised to avoid strenuous exercise for three to four weeks until their spleen has returned to normal size. Other complications, like problems with the nerves, are also rare, affecting about one in 100 people with glandular fever." A severely swollen throat can also result in difficulty swallowing for some people, who may end up needing a short stay in hospital.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Tips to Prevent The Fever',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          "It has been found that mosquitoes thrive in unhygienic or dirty surroundings especially stagnating water. Refrain from keeping buckets of water uncovered. You also need to make sure you change the water in your fountain, flower vases or bird baths everyday which will not give a chance for mosquitoes to breed in. Make sure to dispose garbage properly and never pile it."),
                    )
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
