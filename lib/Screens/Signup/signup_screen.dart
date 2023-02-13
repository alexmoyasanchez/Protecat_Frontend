import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/models.dart';
import 'package:flutter_auth/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<User> createUser(String username, String password, String email) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/users/new/' + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password' : password,
      'email' : email,
      'name': "",
      'imageUrl' : "",
      
    }),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al registrar usuario.');
  }
}


class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      body: Body(),
    );
  }
}
