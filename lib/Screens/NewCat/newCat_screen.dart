import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewCat/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future createCat(
    String name,
    String sex,
    String weight,
    String compatibilities,
    String incompatibilities,
    String diseases,
    String imageUrl) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/cats/new/' + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'sex': sex,
      'weight': weight,
      'compatibilities': compatibilities,
      'incompatibilities': incompatibilities,
      'diseases': diseases,
      'imageUrl': imageUrl,
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al crear"); 
  }
}

class NewCatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Nuevo gato", 
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