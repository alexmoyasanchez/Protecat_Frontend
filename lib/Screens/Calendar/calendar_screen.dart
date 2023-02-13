import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Calendar/components/body.dart';
import 'package:flutter_auth/constants.dart';
import '../../SideBar.dart';
class CalendarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text("Calendario",
        style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}