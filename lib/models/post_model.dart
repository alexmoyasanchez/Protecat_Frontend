import 'package:flutter/material.dart';

class Post {
  final String id;
  final Map<String, dynamic> user;
  final String text;
  final String date;
  final String imageUrl;
  final List<dynamic> likes;

  const Post({
    @required this.id,
    this.user,
    @required this.text,
    @required this.date,
    this.imageUrl,
    @required this.likes
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: json['user'],
      text: json['text'],
      date: json['date'],
      imageUrl: json['imageUrl'],
      likes: json['likes']
    );
  }
}