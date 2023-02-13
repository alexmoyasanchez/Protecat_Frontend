import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/EditPerfil/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/models.dart';
import 'package:flutter_auth/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<User> editarUser(String username, String password, String email, String imageUrl) async {
  final response = await http.put(
    Uri.parse('http://192.168.1.132:3000/users/update/' + currentUser.id ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password' : password,
      'email' : email,
      'imageUrl' : imageUrl,
    }),
    
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al editar usuario.');
  }
}

class EditPerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Editar perfil",
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