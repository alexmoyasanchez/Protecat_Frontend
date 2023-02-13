import 'package:flutter/material.dart';

class User{
  final String id;
  final String username;
  final String password;
  final String email;
  final String imageUrl;
  final List<dynamic> tasks;

  User({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.email,
    @required this.imageUrl,
    @required this.tasks
  } 
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],      
      password: json['password'],
      email: json['email'],
      imageUrl: "",
      tasks: json['tasks']
    );
  }
}