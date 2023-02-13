import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/UserList/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<User>> getUsers() async {
  List<User> users = [];
  
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/users/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    User user = User(
        id: u["id"],
        username: u["username"],
        password: u["password"],
        email: u["email"],
        imageUrl: "",
        tasks: u["tasks"],
      );
    users.add(user);
  }
  return users;
}

class ListaUsuariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: DetailsColor),
        backgroundColor: Background,
        title: Text(
          'Ranking',
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
