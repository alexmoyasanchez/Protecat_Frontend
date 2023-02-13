import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CatsList/components/body.dart';
import 'package:flutter_auth/Screens/NewCat/newCat_screen.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/cat_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:localstorage/localstorage.dart';


Future<Cat> updateCat(
  Cat cat,
) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/cats/update/' +
        cat.id +
        "/" +
        currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': cat.id,
      'name': cat.name,
      'sex': cat.sex,
      'weight': cat.weight,
      'compatibilities': cat.compatibilities,
      'incompatibilities': cat.incompatibilities,
      'diseases': cat.diseases,
      'imageUrl': cat.imageUrl,
    }),
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Cat.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar el perfil del gato');
  }
}

Future<List<Cat>> getCats() async {
  final LocalStorage storage = new LocalStorage('My App');
  List<Cat> cats = [];
  var colony2;
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/cats/'),
      headers: <String, String>{
        'x-access-token': storage.getItem('token'),
      });
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    if (u["colony"].length == 0) {
      colony2 = nullColony;
    } else {
      colony2 = u["colony"][0];
    }
    print(data.body);
    Cat cat = Cat(
        id: u["id"],
        name: u["name"],
        sex: u["sex"],
        weight: u["weight"],
        compatibilities: u["compatibilities"],
        incompatibilities: u["incompatibilities"],
        diseases: u["diseases"],
        imageUrl: u["imageUrl"],
        colony: colony2);

    cats.add(cat);
  }
  return cats;
}

Future<List<String>> getCatsNames() async {
  //final LocalStorage storage = new LocalStorage('My App');
  List<String> cats = [];
  List<dynamic> cats2 = [];

  final data = await http.get(
      Uri.parse('http://192.168.1.132:3000/colonies/getColony/' + '0'),
      headers: <String, String>{
        //'x-access-token': storage.getItem('token'),
      });
  var jsonData = json.decode(data.body);
  cats2 = jsonData["cats"];
  for (var u in cats2) {
    cats.add(u["name"]);
  }
  return cats;
}

Future<Cat> getCat(String id) async {
  final data =
      await http.get(Uri.parse('http://192.168.1.132:3000/cats/getCat/' + id));
  var u = json.decode(data.body);
  Cat cat = Cat(
      id: u["id"],
      name: u["name"],
      sex: u["sex"],
      weight: u["weight"],
      compatibilities: u["compatibilities"],
      incompatibilities: u["incompatibilities"],
      diseases: u["diseases"],
      imageUrl: u["imageUrl"],
      colony: u["colony"]);

  return cat;
}

Future<void> getCatByName(String name) async {
  final data = await http
      .get(Uri.parse('http://192.168.1.132:3000/cats/getCatByName/' + name));
  var u = json.decode(data.body);
  addedCat = u["_id"];
}

Future deleteCat(id) async {
  final response = await http.delete(
    Uri.parse(
        'http://192.168.1.132:3000/cats/delete/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{}),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al eliminar"); 
  }
}

class CatsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Lista gatos",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: () {
              currentPhoto = "";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    currentPhoto = " ";
                    return NewCatScreen();
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
