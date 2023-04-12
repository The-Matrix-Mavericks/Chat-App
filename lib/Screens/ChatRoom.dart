import 'dart:io';
import 'package:chat/calling/video.dart';
import 'package:chat/showProfile.dart/ShowProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../calling/voice.dart';
import 'package:custom_clippers/custom_clippers.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
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
    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set(
      {
        "sendby": _auth.currentUser!.displayName,
        "message": "",
        "type": "img",
        "time": FieldValue.serverTimestamp(),
      },
    );

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError(
      (error) async {
        await _firestore
            .collection('chatroom')
            .doc(chatRoomId)
            .collection('chats')
            .doc(fileName)
            .delete();
        status = 0;
      },
    );

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7165D6),
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection("users").doc(userMap['uid']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Text(userMap['name']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowProfile(
                                      email: userMap['email'],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              snapshot.data!['status'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width / 8.8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => voiceCall(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.call,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: size.width / 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => videoCall(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.video_call_sharp,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: size.width / 45,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: size.height / 1.28,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            // Container(
            //   padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            //   height: size.height / 10,
            //   width: size.width,
            //   alignment: Alignment.center,
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: size.height / 12,
            //     width: size.width / 1.1,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //           height: size.height / 13,
            //           width: size.width / 1.3,
            //           child: TextField(
            //             controller: _message,
            //             // maxLength: 2,
            //             maxLines: 2,
            //             decoration: InputDecoration(
            //                 suffixIcon: IconButton(
            //                   onPressed: () => getImage(),
            //                   icon: Icon(Icons.photo),
            //                 ),
            //                 hintText: "Send Message",
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                 )),
            //           ),
            //         ),
            // IconButton(
            //   icon: Icon(Icons.send),
            //   onPressed: onSendMessage,
            // ),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(20),
            //       topRight: Radius.circular(20),
            //       bottomLeft: Radius.circular(20),
            //       bottomRight: Radius.circular(20),
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black38,
            //         spreadRadius: 2,
            //         blurRadius: 10,
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Container(
            //             // padding: EdgeInsets.only(left: 0),
            //             child: IconButton(
            //               icon: Icon(Icons.photo, size: 23),
            //               color: Color(0xFF7165D6),
            //               onPressed: () => getImage(),
            //             ),
            //           ),
            //           Container(
            //             // padding: EdgeInsets.only(left: 0),
            //             child: IconButton(
            //               icon: Icon(Icons.emoji_emotions_outlined, size: 23),
            //               color: Color(0xFF7165D6),
            //               onPressed: () => getImage(),
            //             ),
            //           ),
            //         ],
            //       ),
            //       // SizedBox(
            //       //   width: 2,
            //       // ),

            //       Padding(
            //         padding: EdgeInsets.only(left: 0),
            //         child: Container(
            //           alignment: Alignment.centerRight,
            //           width: MediaQuery.of(context).size.width / 1.6,
            //           child: TextFormField(
            //               decoration: InputDecoration(
            //             hintText: "Type somethig",
            //             border: InputBorder.none,
            //           )),
            //         ),
            //       ),
            //       Spacer(),
            //       Padding(
            //         padding: EdgeInsets.only(right: 10),
            //         child: IconButton(
            //           icon: Icon(
            //             Icons.send,
            //             size: 25,
            //           ),
            //           onPressed: onSendMessage,
            //           color: Color(0xFF7165D6),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: size.height / 10,
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(left: 0),
                          child: IconButton(
                            icon: Icon(Icons.photo, size: 25),
                            color: Color(0xFF7165D6),
                            onPressed: () => getImage(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(1),
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: size.width / 1.8,
                        child: TextFormField(
                          controller: _message,
                          decoration: InputDecoration(
                            hintText: "Type something",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 25,
                        ),
                        onPressed: onSendMessage,
                        color: Color(0xFF7165D6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    if (map['type'] == "text") {
      return Container(
        width: size.width,
        alignment: map['sendby'] == _auth.currentUser!.displayName
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ClipPath(
          clipper: map['sendby'] == _auth.currentUser!.displayName
              ? UpperNipMessageClipper(MessageType.receive)
              : LowerNipMessageClipper(MessageType.send),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: map['sendby'] == _auth.currentUser!.displayName
                  ? Color(0xFF7165D6)
                  : Colors.green.shade100,
            ),
            child: Column(
              children: [
                Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 16,
                    color: map['sendby'] == _auth.currentUser!.displayName
                        ? Colors.white
                        : Colors.black,
                    // backgroundColor:
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: size.height / 2.5,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        alignment: map['sendby'] == _auth.currentUser!.displayName
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowImage(
                imageUrl: map['message'],
              ),
            ),
          ),
          child: Container(
            height: size.height / 2.5,
            width: size.width / 2,
            decoration: BoxDecoration(border: Border.all()),
            alignment: map['message'] != "" ? null : Alignment.center,
            child: map['message'] != ""
                ? Image.network(
                    map['message'],
                    fit: BoxFit.cover,
                  )
                : CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//
