import 'package:chat/chatBot/bot.dart';
import 'package:chat/checkup/OneMinuteChechup.dart';
import 'package:chat/form/form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../form/visitclinic.dart';

// ignore: must_be_immutable
class HomeScreen1 extends StatefulWidget {
  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  // const HomeScreen1({super.key});
  List symptoms = [
    "Temprature",
    "Snuffle",
    "Fever",
    "Cough",
    "Cold",
  ];

  List imgs = [
    "doc1.png",
    "doc2.jpg",
    "doc3.jpg",
    "doc4.jpg",
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Map<String, dynamic>? userMap;

  bool isLoading = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    _setMessage();
  }

  void _setMessage() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(
      () {
        isLoading = true;
      },
    );
    _firestore
        .collection('users')
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .get()
        .then(
      (value) {
        setState(
          () {
            userMap = value.docs[0].data();
            isLoading = false;
          },
        );
        // print(userMap);
      },
    );
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _auth.currentUser != null
                      ? "Hello, ${_auth.currentUser!.displayName}"
                      : "Hello, User",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userMap?['url'] != null
                      ? "${userMap?['url']}"
                      : "https://imgs.search.brave.com/05TBeNcAKK_r3R0LB3pKtpxtWDXWh8ivakrk0aYd5_I/rs:fit:322:294:1/g:ce/aHR0cHM6Ly9zdGVl/bWl0aW1hZ2VzLmNv/bS9EUW1XQW9lVXBR/RFRaaUNoSjUxTFRG/U0NBMndWcUEybWpZ/WlVUWE5teldVS1pO/Qi9kb2N1Ym90Lmdp/Zg.gif"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClinicVisitForm(),
                    ),
                  );
                },
                child: Container(
                  height: size.height / 4.0,
                  width: size.width / 2.2,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 4)
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Color(0xFFF0EEFA), shape: BoxShape.circle),
                          child: Icon(
                            Icons.medical_services_outlined,
                            color: Color(0xFF7165D6),
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Clinic Visit",
                          style: TextStyle(
                              fontSize: 18,
                              // color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Make an appointment",
                          style: TextStyle(
                            // fontSize: 18,
                            color: Colors.black54,
                            // fontWeight: FontWeight.w500
                          ),
                        ),
                      ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkup(),
                    ),
                  );
                },
                child: Container(
                  height: size.height / 4.0,
                  width: size.width / 2.2,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(0xFF7165D6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 4)
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.medication_liquid_sharp,
                            color: Color(0xFF7165D6),
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "1 min. Checkup",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Get Instant checkup",
                          style: TextStyle(
                            // fontSize: 18,
                            color: Colors.white54,
                            // fontWeight: FontWeight.w500
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "What are your symptoms?",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: symptoms.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2),
                      ]),
                  child: Center(
                      child: Text(
                    symptoms[index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  )),
                );
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15),
          //   child: Text(
          //     "Popular Doctors",
          //     style: TextStyle(
          //         fontSize: 23,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black54),
          //   ),
          // ),
          // GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   itemCount: 4,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => AppointmentScreen1()));
          //       },
          //       child: Container(
          //           margin: EdgeInsets.all(10),
          //           padding: EdgeInsets.symmetric(vertical: 15),
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: Colors.black12,
          //                     blurRadius: 4,
          //                     spreadRadius: 2),
          //               ]),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               CircleAvatar(
          //                 radius: 35,
          //                 backgroundImage: AssetImage("images/${imgs[index]}"),
          //               ),
          //               Text(
          //                 "Dr. Doctor Name",
          //                 style: TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black54),
          //               ),
          //               Text(
          //                 "Therapist",
          //                 style: TextStyle(
          //                     // fontSize: 18,
          //                     // fontWeight: FontWeight.w500,
          //                     color: Colors.black54),
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(
          //                     Icons.star,
          //                     color: Colors.amber,
          //                     size: 20,
          //                   ),
          //                   Text(
          //                     "4.9",
          //                     style: TextStyle(
          //                         fontSize: 12,
          //                         // fontWeight: FontWeight.w500,
          //                         color: Colors.black54),
          //                   )
          //                 ],
          //               )
          //             ],
          //           )),
          //     );
          //   },
          // ),
          Center(
              child: Container(
                  height: 190, child: Image.asset("images/botgif.jpg"))),
          Center(
            child: Text(
              "Your AI chatbot is here !",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: TextButton(
              child: Text("Tap here to chat 💬",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Bot()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
