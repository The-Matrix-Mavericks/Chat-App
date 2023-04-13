import 'package:chat/Schedule/reschedule.dart';
import 'package:chat/Screens/HomeScreen.dart';
import 'package:chat/Screens/MainPage.dart';
import 'package:chat/screens2/home_screen.dart';
import 'package:chat/widgets/upcoming_schedule.dart';
import 'package:flutter/material.dart';

class Pop2 extends StatelessWidget {
  const Pop2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Successfully Scheduled'),
        content: Text('done, Hope you are fine!'),
        actions: <Widget>[
          TextButton(
            child: InkWell(
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  MainPage(),
                      ),
                    ),
                child: Text('OK')),
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
