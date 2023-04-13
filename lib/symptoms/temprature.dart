import 'package:flutter/material.dart';

class Temprature extends StatelessWidget {
  const Temprature({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('About Temprature..')),
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
                child: Image.asset("images/temp.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 700,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Things to know about Temprature',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '1.Your body is great thermoregulator:-',
                      style: TextStyle(fontSize: 19),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                          'Our body has an amazing ability to keep its temperature within safe range to keep you healthy, no matter what conditions you are exposed to outside the body. When you feel hot, you start sweating, which cools you body down. When you feel cold, you start shivering, which is involuntary muscle contractions that generate heat. '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '2. Normal body temperature:-',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Text(
                        'It is commonly accepted that normal human body temperature is 98.6 degrees F or 37 degrees C. However, there is also a number of variations to normal body temperature that depend on many factors, such as the time of the day, outside temperature, age of the person and others.'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Tips to Prevent The Temprature',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          'Keep in mind: Electric fans may provide comfort, but when the temperature is in the high 90s, they will not prevent heat-related illness. Taking a cool shower or bath or moving to an air-conditioned place is a much better way to cool off. Use your stove and oven less to maintain a cooler temperature in your home.'),
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
