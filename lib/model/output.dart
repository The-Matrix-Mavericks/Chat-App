// import 'package:tflite/tflite.dart';
// import 'package:flutter/material.dart';

// class output extends StatefulWidget {
//   String input;
//   output(this.input);

//   @override
//   State<output> createState() => _outputState();
// }

// class _outputState extends State<output> {
//   List? _outputs;
//   String? _image;
//   bool _loading = false;
//   @override
//   void initState() {
//     super.initState();
//     _loading = false;
//     loadModel().then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

//   // classifyImage(File image) async {
//   //   var output = await Tflite.runModelOnImage(
//   //     // path: _image,
//   //     numResults: 2,
//   //     threshold: 0.5,
//   //     imageMean: 127.5,
//   //     imageStd: 127.5,
//   //   );
//   //   setState(() {
//   //     _loading = false;
//   //     _outputs = output;
//   //   });
//   // }

//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Output"),
//         ),
//         body: _outputs != null
//             ? Text(
//                 "${_outputs![0]["label"]}",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20.0,
//                   background: Paint()..color = Colors.white,
//                 ),
//               )
//             : Container(),
//       ),
//     );
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/modelForSentimentAnalysis.tflite",
//       labels: "assets/label.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }
