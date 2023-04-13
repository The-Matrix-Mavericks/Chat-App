import 'package:chat/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens2/home_screen.dart';
import 'package:chat/screens2/message_screen.dart';
import 'package:chat/screens2/schedule_screen.dart';
import 'package:chat/screens2/setting_screen.dart';

import '../chatting app/chat_home.dart';
import '../payment/payment.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectIndex = 0;
  final _scresns = [
    // home screen
    HomeScreen1(),
    // message screen
    // HomeScreen(),
    ChatHomeScreen(),
    // schedule screen
    ScheduleScreen1(),
    UPIPayment(),
    // setting screen
    SettingScreen1(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _scresns[_selectIndex],
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 241, 239, 249),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF7165D6),
          unselectedItemColor: Colors.black45,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          currentIndex: _selectIndex,
          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "Schedule"),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: "Payment"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
