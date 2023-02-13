import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Feed/components/body.dart';
import 'package:flutter_auth/components/create_post_container.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SideBar.dart';
import '../../models/post_model.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Image.asset(
          "assets/images/logoProtecat.png",
          width: 155,
          height: 55,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreatePostContainer();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Body(),
    );
  }
}

Future createPost(
    String userID, String text, String imageUrl, String date) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.132:3000/posts/new/' + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userID': userID,
      'text': text,
      'imageUrl': imageUrl,
      'date': date,
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al crear"); 
  }
}

Future<List<Post>> getPosts() async {
  List<Post> posts = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/posts/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Post post = Post(
      id: u["id"],
      user: u["user"],
      text: u["text"],
      imageUrl: u["imageUrl"],
      date: u["date"],
      likes: u["likes"],
    );
    posts.add(post);
  }
  print(posts.length);
  posts.sort((b, a) => a.date.compareTo(b.date));
  return posts;
}

Future<void> giveLike(String idUser, String idPost) async {
  final response = await http.put(
    Uri.parse('http://192.168.1.132:3000/posts/like/' + idUser + '/' + idPost),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode != 201) {
    throw Exception('Error al dar un like.');
  }
}

Future<void> undoLike(String idUser, String idPost) async {
  final response = await http.put(
    Uri.parse(
        'http://192.168.1.132:3000/posts/undoLike/' + idUser + '/' + idPost),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode != 201) {
    throw Exception('Error al deshacer un like.');
  }
}

Future<void> checkLike(String idUser) async {
  final data = await http.get(
    Uri.parse('http://192.168.1.132:3000/posts/checkLike/' + idUser),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  var jsonData = json.decode(data.body);
  user_id = jsonData["_id"];
}
