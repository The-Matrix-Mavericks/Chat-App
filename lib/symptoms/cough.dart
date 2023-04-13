import 'package:flutter/material.dart';

class Cough extends StatelessWidget {
  const Cough({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('About Cough..')),
          backgroundColor:Color(0xFF7165D6),
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
                height: 550,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Things to know about Cough',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          'A cough is the body\'s way of defending itself, Dr. Cameron explains. \"If you have a runny nose and some congestion, you might get post-nasal drip, which can irritate the bronchioles (small passageways in the lungs) and cause coughing," she says. "Coughing is a way to clear the lungs and expel mucus."'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          '"A lot of the over-the-counter medications have decongestants and antihistamines. Decongestants are associated with cardiac arrhythmias, and antihistamines have an increased risk of drowsiness and depression of breathing," she says. "So those medications, if not dosed according to weight or given at the proper intervals, can be dangerous."'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Tips to Prevent The Cough',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                          "Never give this type of medicine to children under 4 years old, because it can have serious side effects. Ask your doctor before you give any of these products to children ages 4 to 6. They're safe after age 6. For children 1 and up, try 1/2 to 1 teaspoon of honey to help them suppress their cough."),
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
