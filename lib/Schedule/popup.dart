import 'package:chat/Schedule/reschedule.dart';
import 'package:chat/Screens/HomeScreen.dart';
import 'package:chat/screens2/home_screen.dart';
import 'package:chat/widgets/upcoming_schedule.dart';
import 'package:flutter/material.dart';

class Pop extends StatelessWidget {
  const Pop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Cancelled Schedule'),
        content: Text('Cancelled, Hope you are fine!'),
        actions: <Widget>[
          TextButton(
            child:
                InkWell(onTap: () => Navigator.pop(context), child: Text('OK')),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => example()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
// class example extends StatelessWidget {
//   const example({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ();
//   }
// }