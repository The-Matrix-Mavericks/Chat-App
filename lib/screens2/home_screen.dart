import 'package:chat/chatBot/bot.dart';
import 'package:chat/checkup/OneMinuteChechup.dart';
import 'package:chat/form/form.dart';
import 'package:chat/symptoms/cough.dart';
import 'package:chat/symptoms/fever.dart';
import 'package:chat/symptoms/headache.dart';
import 'package:flutter/services.dart';
import 'package:chat/symptoms/temprature.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import '../form/visitclinic.dart';
import '../model/output.dart';
import '../symptoms/cold.dart';

// ignore: must_be_immutable
class HomeScreen1 extends StatefulWidget {
  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  // const HomeScreen1({super.key});
  List symptoms = [
    "Temprature",
    "Headache",
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

  // _launchUrl() async {
  //   // const _url = "https://google.com";
  //   // ignore: deprecated_member_use
  //   const _url = '';
  //   // ignore: deprecated_member_use
  //   if (await canLaunch(_url)) {
  //     // ignore: deprecated_member_use
  //     await launch(_url);
  //   } else {
  //     throw 'Could not launch $_url';
  //   }
  // }
  openBrowserTab() async {
    await FlutterWebBrowser.openWebPage(
      url: 'https://lalithakre.github.io/Data-Visualization-of-ML-Model/',
      customTabsOptions: CustomTabsOptions(
          colorScheme: CustomTabsColorScheme.dark,
          toolbarColor: Color(0xFF7165D6),
          secondaryToolbarColor: Color(0xFF7165D6),
          navigationBarColor: Color(0xFF7165D6),
          addDefaultShareMenuItem: true,
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true),
    );
    // androidToolbarColor: Colors.deepPurple);
  }

  final TextEditingController _input = TextEditingController();
  late String Store;

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
                  backgroundImage: NetworkImage(userMap?['_url'] != null
                      ? "${userMap?['_url']}"
                      : "https://imgs.search.brave.com/05TBeNcAKK_r3R0LB3pKtpxtWDXWh8ivakrk0aYd5_I/rs:fit:322:294:1/g:ce/aHR0cHM6Ly9zdGVl/bWl0aW1hZ2VzLmNv/bS9EUW1XQW9lVXBR/RFRaaUNoSjUxTFRG/U0NBMndWcUEybWpZ/WlVUWE5teldVS1pO/Qi9kb2N1Ym90Lmdp/Zg.gif"),
                )
              ],
            ),
          ),
          Divider(
            height: 9,
            // thickness: 2,
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
                      builder: (context) => Checkup(0),
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
          InkWell(
            onTap: () {
              openBrowserTab();
              // ignore: deprecated_member_use
              // launch(
              //     'https://lalithakre.github.io/Data-Visualization-of-ML-Model/');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "View Analysis",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                    height: 50,
                    child: Image.asset("images/4_Bar_Chart_10_Seconds.webp"))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 1,
          ),
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
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 30,
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
          // SizedBox(
          //   height: 60,
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: symptoms.length,
          //   scrollDirection: Axis.horizontal,
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: () => Navigator.push(context,
          //           MaterialPageRoute(builder: (_) => symptoms[index])),
          //       child: Container(
          //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //         padding: EdgeInsets.symmetric(horizontal: 15),
          //         decoration: BoxDecoration(
          //             color: Color(0xFFF4F6FA),
          //             borderRadius: BorderRadius.circular(10),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.black12,
          //                   blurRadius: 4,
          //                   spreadRadius: 2),
          //             ]),
          //         child: Center(
          //             child: Text(
          //           symptoms[index],
          //           style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.w600,
          //               color: Colors.black54),
          //         )),
          //       ),
          //     );
          //   },
          // ),
          // ),
          SizedBox(
            height: 25,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cold(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 150,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Cold",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cough(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 150,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Cough",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fever(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 150,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "fever",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Headache(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 150,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Headache",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Temprature(),
                      ),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: 150,
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Temp",

                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: _input,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  // Store =_input.text;
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => output(Store)));
                },
                child: Text(
                  "Check Rating",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7165D6)),
                )),
          )
        ],
      ),
    );
  }
}
