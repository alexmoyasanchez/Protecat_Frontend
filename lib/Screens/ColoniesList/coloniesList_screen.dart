import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/map_screen.dart';
import 'package:flutter_auth/Screens/ColoniesList/components/body.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/cat_model.dart';
import 'package:flutter_auth/models/colony_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<Colony>> getAllColonies() async {
  List<Colony> colonies = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/colonies/' + currentUser.id));
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    print(data.body);
    Colony colony = Colony(
        id: u["id"],
        name: u["name"],
        locationx: u["locationx"],
        locationy: u["locationy"],
        observations: u["observations"],
        cats: u["cats"]
    );

    colonies.add(colony);
  }
  print(colonies.length);
  return colonies;
}

Future<Colony> updateColony(
    Colony colony, ) async {
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/colonies/update/' + colony.id + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': colony.id,
      'name': colony.name,
      'locationx': colony.locationx,
      'locationy': colony.locationy,
      'observations': colony.observations,
    }),
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Colony.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al editar la colonia');
  }
}

Future<void> addCat(String id, String cat) async{
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/colonies/addCat/' + id + "/" + cat + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Colony.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al añadir el gato');
  }
}

Future<List<Cat>> getCatsOfColony(String id) async {
  List<Cat> cats = [];
  List<dynamic> cats2 = [];
  final data = await http.get(Uri.parse('http://192.168.1.132:3000/colonies/getColony/' + id));
  var jsonData = json.decode(data.body);
  cats2 = jsonData["cats"];
  for (var u in cats2) {
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
        colony: jsonData,
    );

    cats.add(cat);
  }
  return cats;
}

Future<void> removeCatOfColony(String id, String cat) async{
  final data = await http.put(
    Uri.parse('http://192.168.1.132:3000/colonies/removeCatOfColony/' + id + "/" + cat + "/" + currentUser.email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(data.request);
  if (data.statusCode == 201) {
    return Colony.fromJson(jsonDecode(data.body));
  } else {
    throw Exception('Error al retirar el gato');
  }
}

class ColoniesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(
      ),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Colonias", 
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
              TextButton( child: Text("Mapa", style: TextStyle(color: Colors.white, fontSize: 20),),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MapScreen();
                      },
                    ),
                  );
              })
            ],
      ),
      body: Body(),
    );
  }
}
