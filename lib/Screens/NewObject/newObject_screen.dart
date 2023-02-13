import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewObject/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future createObject(
    String name,
    String imageUrl,
    String price,
    String description,
    String units) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/objects/new/' + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
      'units': units
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al crear"); 
  }
}

class NewObjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Crear objeto",
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