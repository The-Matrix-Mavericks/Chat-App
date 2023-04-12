import 'dart:io';
import 'package:chat/Authenticate/Methods.dart';
import 'package:chat/form/form.dart';
import 'package:chat/screens2/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat/showProfile.dart/ShowProfile.dart';
import 'package:uuid/uuid.dart';

import 'aboutUs.dart';

class SettingScreen1 extends StatefulWidget {
  @override
  State<SettingScreen1> createState() => _SettingScreen1State();
}

class _SettingScreen1State extends State<SettingScreen1> {
  // const SettingScreen1({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then(
      (xFile) {
        if (xFile != null) {
          imageFile = File(xFile.path);
          uploadImage();
        }
      },
    );
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError(
      (error) async {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('url')
            .doc(fileName)
            .delete();
        status = 0;
      },
    );

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({"url": imageUrl});

      print(imageUrl);
    }
  }

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
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 50,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: SizedBox(
                height: 250,
                width: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  // fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(userMap?['url'] != null
                          ? "${userMap?['url']}"
                          : "https://imgs.search.brave.com/05TBeNcAKK_r3R0LB3pKtpxtWDXWh8ivakrk0aYd5_I/rs:fit:322:294:1/g:ce/aHR0cHM6Ly9zdGVl/bWl0aW1hZ2VzLmNv/bS9EUW1XQW9lVXBR/RFRaaUNoSjUxTFRG/U0NBMndWcUEybWpZ/WlVUWE5teldVS1pO/Qi9kb2N1Ym90Lmdp/Zg.gif"),
                    ),
                    Positioned(
                        bottom: 0,
                        right: -15,
                        child: RawMaterialButton(
                          onPressed: () {
                            getImage();
                          },
                          elevation: 2.0,
                          fillColor: Color(0xFFF5F6F9),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.blue,
                            size: 20,
                          ),
                          padding: EdgeInsets.all(1.0),
                          shape: CircleBorder(),
                        )),
                  ],
                ),
              ),
              title: Text(
                _auth.currentUser != null
                    ? "Hello, ${_auth.currentUser!.displayName}"
                    : "Hello, User",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              subtitle: Text(
                "User",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Divider(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowProfile(
                        email: _auth.currentUser != null
                            ? "${_auth.currentUser!.email}"
                            : "demo@gmail.com"),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_3_outlined,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(
              height: 20,
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Colors.deepPurple.shade200,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Icon(
            //       Icons.notifications_active,
            //       color: Colors.deepPurple,
            //       size: 35,
            //     ),
            //   ),
            //   title: Text(
            //     "Notifications",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       fontSize: 20,
            //     ),
            //   ),
            //   trailing: Icon(Icons.arrow_forward_ios_rounded),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PrivacyScreen(),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.privacy_tip,
                  color: Colors.indigo,
                  size: 35,
                ),
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Medicalform(),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.medical_information,
                  color: Colors.green,
                  size: 35,
                ),
              ),
              title: Text(
                "Medical Form",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AboutUsScreen(),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.orange,
                  size: 35,
                ),
              ),
              title: Text(
                "About Us",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(
              height: 40,
            ),
            // SizedBox(
            //   height: 20,
            // ),
            ListTile(
              onTap: () => logOut(context),
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
