import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
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
    "do you have back_pain ?",
    "do you have loss_of_smell ?",
    "do you have internal_itching ?",
    "do you have hip_joint_pain ?",
    "do you have brittle_nails ?",
    "do you have polyuria ?",
    "do you have blood_in_sputum ?",
    "do you have silver_like_dusting ?",
    "do you have unsteadiness ?",
    "do you have lack_of_concentration ?",
    "do you have dischromic_patches ?",
    "do you have abnormal_menstruation ?",
    "do you have weight_loss ?",
    "do you have muscle_pain ?",
    "do you have fluid_overload ?",
    "do you have movement_stiffness ?",
    "do you have mild_fever ?",
    "do you have belly_pain ?",
    "do you have neck_pain ?",
    "do you have rusty_sputum ?",
    "do you have prominent_veins_on_calf ?",
    "do you have depression ?",
    "do you have yellow_crust_ooze ?",
    "do you have red_spots_over_body ?",
    "do you have altered_sensorium ?",
    "do you have continuous_feel_of_urine ?",
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
  ];
  int count;

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
                                      builder: (context) => Example(),
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
