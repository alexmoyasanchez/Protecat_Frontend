import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewObject/newObject_screen.dart';
import 'package:flutter_auth/Screens/objectsList/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/object_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<Object> updateObject(
    Object object, ) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/objects/update/' + object.id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'appliobjection/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': object.id,
      'name': object.name,
      'imageUrl': object.imageUrl,
      'price': object.price.toString(),
      'description' : object.description,
      'units' : object.units.toString()
    }),
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Object.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar el objeto');
  }
}

Future deleteObject(id) async {
  final response = await http.delete(
    Uri.parse('http://192.168.1.132:3000/objects/delete/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al eliminar"); 
  }
}

Future<void> subUnit (id) async {
  final response = await http.put(
    Uri.parse('http://192.168.1.132:3000/objects/subUnit/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al eliminar"); 
  }
}

Future<void> addUnit (id) async {
  final response = await http.put(
    Uri.parse('http://192.168.1.132:3000/objects/addUnit/' + id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception("Error al eliminar"); 
  }
}

Future<List<Object>> getObjects() async {
  List<Object> objects = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/objects/'));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Object object = Object(
        id: u["id"],
        name: u["name"],
        imageUrl: u["imageUrl"],
        price: u["price"].toString(),
        description: u['description'],
        units: u['units']);

    objects.add(object);
  }
  print(objects.length);
  return objects;
}

Future<Object> getobject(String id) async {
  final data =
      await http.get(Uri.parse('http://192.168.1.132:3000/objects/getobject/' + id));
  var u = json.decode(data.body);
  Object object = Object(
      id: u["id"],
        name: u["name"],
        imageUrl: u["imageUrl"],
        price: u["price"],
        description: u["description"],
        units: u["units"]);

  return object;
}

class ObjectsListcreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(
      ),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Lista de objetos", 
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
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context){
                    currentPhoto = " ";
                    return NewObjectScreen();
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
