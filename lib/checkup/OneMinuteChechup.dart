import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import '../model/notPredict.dart';
import '../model/predict.dart';

class Checkup extends StatefulWidget {
  int count;

  Checkup(this.count);

  @override
  State<Checkup> createState() => _CheckupState(count);
}

class _CheckupState extends State<Checkup> {
  final AppinioSwiperController controller = AppinioSwiperController();

  final data = [
    "Do you have high temprature ?",
    "do you have back pain ?",
    "do you have loss of smell ?",
    "do you have internal itching ?",
    "do you have hip joint pain ?",
    "do you have brittle nails ?",
    "do you have polyuria ?",
    "do you have blood in sputum ?",
    "do you have silver like dusting ?",
    "do you have unsteadiness ?",
    "do you have lack of concentration ?",
    "do you have dischromic patches ?",
    "do you have abnormal menstruation ?",
    "do you have weight loss ?",
    "do you have muscle pain ?",
    "do you have fluid overload ?",
    "do you have movement stiffness ?",
    "do you have mild fever ?",
    "do you have belly pain ?",
    "do you have neck pain ?",
    "do you have rusty sputum ?",
    "do you have prominent veins on calf ?",
    "do you have depression ?",
    "do you have yellow crust ooze ?",
    "do you have red spots over body ?",
    "do you have altered sensorium ?",
    "do you have continuous feel of urine ?",
    "do you have palpitations ?",
  ];
  List symp = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  int count;
  int check = 0;
  _CheckupState(this.count);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Get Instant checkup"),
          ),
        ),
        body: Center(
          child: Container(
            color: Color.fromARGB(255, 149, 118, 201),
            height: 550,
            width: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                count < data.length
                    ? Column(
                        children: [
                          Center(
                            child: Text(
                              data[count],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        symp[count] = 1;
                                        print(symp[count]);
                                        count++;
                                        check++;
                                      },
                                    );
                                  },
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        print(symp[count]);
                                        count++;
                                      },
                                    );
                                  },
                                  child: Text("No"))
                            ],
                          )
                        ],
                      )
                    : Center(
                        child: Column(
                          children: [
                            Text(
                              "Your report is ready \nClick here to View",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          check < 5 ? Example() : Example1(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Predict",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
