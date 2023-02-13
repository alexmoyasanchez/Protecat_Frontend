import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/body.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../../models/task_model.dart';


Future<User> login(String email, String password) async {
  final LocalStorage storage = new LocalStorage('My App');
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'password' : password,
      'email' : email,
    }),
    
  );

  if (response.statusCode == 200) {
    storage.setItem('token', jsonDecode(response.body)['token']);
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al iniciar sesión.');
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      body: Body(),
    );
  }
}

Future<void> saveUser(String email, String password){
final List<Task> task = [];

    final User user = User(
      id: currentUser.id,
      username: currentUser.username,
      password: password,
      email: email,
      imageUrl: '',
      tasks: task,
    );

    currentUser = user;
  }

Future<void> getUserByEmail() async{
  User user;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/users/getUserByEmail/' + currentUser.email));
  var jsonData = json.decode(data.body);
  user = User(
    id: jsonData["id"],
    username: jsonData["username"],
    password: jsonData["password"],
    email: jsonData["email"],
    imageUrl: jsonData["imageUrl"],
    tasks: jsonData["tasks"],
  );
  currentUser = user;

}

Future<void> getUser() async{
  User user;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/users/getUser/' + currentUser.id));
  var jsonData = json.decode(data.body);
  user = User(
    id: jsonData["id"],
    username: jsonData["username"],
    password: jsonData["password"],
    email: jsonData["email"],
    imageUrl: jsonData["imageUrl"],
    tasks: jsonData["tasks"],
  );

}

Future<String> getUserByUsername(String username) async{
  String user;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/users/getUserByUsername/' + username));
  var jsonData = json.decode(data.body);
  user = jsonData["_id"];
  return user;

}
