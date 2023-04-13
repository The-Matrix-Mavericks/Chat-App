import 'dart:async';
import 'package:chat/Screens/ChatRoom.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const String appId = "85dc7f002b52485d929d98e12592c57f";

void main() => runApp(const MaterialApp(home: voiceCall()));

class voiceCall extends StatefulWidget {
  const voiceCall({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<voiceCall> {
  String channelName = "lallu";
  String token =
      "007eJxTYLjKpZhcqq3zXlip98xvz+rJ+xcsDLl7bzr/fhvmPmuGoA4FBgvTlGTzNAMDoyRTIxMgx9LIMsXSItXQyNTSKNnUPE3c1jylIZCRwWLJSgZGKATxWRlyEnNyShkYAMwmHRc=";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

// Build UI
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: const Text('Voice Calling')),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: [
              // Status text
              // Container(height: 60, child: Center(child: _status())),
              // Container(height: 6, child: Center(child: _status())),
              // Button Row
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(_auth.currentUser!.photoURL !=
                        null
                    ? "$_auth.currentUser.PhotoUrl"
                    : "https://imgs.search.brave.com/05TBeNcAKK_r3R0LB3pKtpxtWDXWh8ivakrk0aYd5_I/rs:fit:322:294:1/g:ce/aHR0cHM6Ly9zdGVl/bWl0aW1hZ2VzLmNv/bS9EUW1XQW9lVXBR/RFRaaUNoSjUxTFRG/U0NBMndWcUEybWpZ/WlVUWE5teldVS1pO/Qi9kb2N1Ym90Lmdp/Zg.gif"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(height: 180, child: Center(child: _status())),
              Container(
                height: size.height / 2.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(
                    //   child: ElevatedButton(
                    //     child: const Text("Join"),
                    //     onPressed: () => {join()},
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("Leave"),
                        onPressed: () => {leave()},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Calling';
    else if (_remoteUid == null)
      statusText = 'Waiting for a  user to join...';
    else
      statusText = 'Calling With --> ${_auth.currentUser!.displayName}';

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            statusText,
            style: TextStyle(fontSize: 25),
          ),
          // Text("data")
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
    WidgetsBinding.instance?.addPersistentFrameCallback((_) => join());
    // join();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
    Navigator.pop(context);
  }

// Clean up the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
    agoraEngine.disableAudio();
    agoraEngine.disableAudioSpectrumMonitor();
    agoraEngine.stopDirectCdnStreaming();
  }

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
