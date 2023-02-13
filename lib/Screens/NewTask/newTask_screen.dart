import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewTask/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future createTask(
    String date,
    String subject,
    String description,
    String volunteer) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/tasks/new/' + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'date': date,
      'subject': subject,
      'description': description,
      'volunteer': volunteer,
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al crear"); 
  }
}

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background2,
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Nueva tarea", 
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}