import 'package:flutter/material.dart';

class Cold extends StatelessWidget {
  const Cold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('About Cold..')),
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
                child: Image.asset("images/cold.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 220,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Things to know about cold',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Winter cold kills more than twice as many Americans as summer heat does. The average snowflake falls at about 3 mph. Many viruses can cause colds, but rhinoviruses are most common. Infections spread through the air and close personal contact.Symptoms of a cold usually include sore throat, runny nose, coughing, sneezing, headaches, and body aches.')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      'Tips to Prevent The Cold',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'While it is impossible to completely prevent the spread of colds, there are steps you can take to reduce your and your family\'s chances of becoming infected with a virus that causes colds:',
                      ),
                    ),
                    Text(
                        'Wash your hands often.\n Avoid touching your face, especially the nose, mouth, and eye areas.Use disposable items if someone in your family is infected. \n Keep household surfaces clean. \n Use paper towels in the kitchen and bathroom for drying hands after hand washing.')
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
