import 'dart:async';
import 'dart:convert';
import 'package:flutter_auth/Screens/CatsList/CatsList_screen.dart';
import 'package:flutter_auth/Screens/ColoniesList/coloniesList_screen.dart';
import 'package:flutter_auth/Screens/ColoniesList/components/body.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/cat_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'dart:math';

import '../../../../../models/colony_model.dart';

class Vectores {}

Future<void> getColonies() async {
  final LocalStorage storage = new LocalStorage('My App');
  latitudes = [];
  coloniesNames = [];
  coloniesObsevations = [];

  longitudes = [];
  final data = await http.get(
    Uri.parse('http://192.168.1.132:3000/colonies/' + currentUser.id),
    headers: <String, String>{
      'x-access-token': storage.getItem('token'),
    },
  );
  var jsonData = json.decode(data.body);
  for (var u in jsonData) {
    Colony colony = Colony(
        id: u["id"],
        name: u["name"],
        locationx: u['locationx'],
        locationy: u['locationy'],
        observations: u['observations'],
        cats: u['cats']);

    latitudes.add(colony.locationx);
    longitudes.add(colony.locationy);
    coloniesNames.add(colony.name);
    coloniesObsevations.add(colony.observations);

    colonies.add(colony);
  }
}

Future<void> getColonyByName(String name) async {
  final data = await http.get(
      Uri.parse('http://192.168.1.132:3000/colonies/getColonyByName/' + name));
  var u = json.decode(data.body);
  Colony colony = Colony(
      id: u["id"],
      name: u["name"],
      locationx: u["locationx"],
      locationy: u["locationy"],
      observations: u["observations"],
      cats: u["cats"]);

  colonySelected = colony;
}

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  Stream<String> get onMarkerTap => _markersController.stream;

  final _markersController = StreamController<String>.broadcast();

  final initialCameraPosition = const CameraPosition(
    target: LatLng(41.2756656, 1.9859211),
    zoom: 15,
  );

  void onMapCreatedyeah(GoogleMapController controller) async {
    await getColonies();
    createMarkers2(latitudes.length, latitudes, longitudes);
  }

  void createMarkers2(int num, List<String> lat, List<String> lon) async {
    List colonies = [];

    for (int i = 0; i < num; i++) {
      LatLng colony = new LatLng(double.parse(lat[i]), double.parse(lon[i]));
      colonies.add(colony);
    }

    for (int i = 0; i < num; i++) {
      final markerId = MarkerId(i.toString());
      AsyncSnapshot snapshot;
      final marker = Marker(
          markerId: markerId,
          position: colonies[i],
          infoWindow: InfoWindow(
            title: (coloniesNames[i].toString()),
            snippet: (coloniesObsevations[i].toString()),
            onTap: () async {
              await getColonyByName(coloniesNames[i].toString());
              navService.pushNamed('/ColonyDetail');
            },
          ),
          onTap: () {
            _markersController.sink.add(i.toString());
          });
      _markers[markerId] = marker;
      notifyListeners();
    }
  }

  double deg2rad(deg) {
    return deg * (pi / 180);
  }

  void dispose() {
    _markersController.close();
    super.dispose();
  }
}

class DetailPage extends StatefulWidget {
  final Colony colony;

  DetailPage(this.colony);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          widget.colony.name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 10.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Nombre",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.colony.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 10.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Coordenadas",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.colony.locationx + "º" + widget.colony.locationy + "º",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Observaciones",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.colony.observations,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Gatos",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: Text(widget.colony.cats.length.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CatsScreen(widget.colony)));
              },
            ),
            SizedBox(height: 20.0),
            RoundedButton(
                margin: 10,
                text: "Modificar observación",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.6,
                height: 20.0,
                press: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditPage(widget.colony);
                      },
                    ),
                  );
                }),
            SizedBox(height: 10.0),
            RoundedButton(
                margin: 10,
                text: "Añadir gato a la colonia",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.6,
                height: 20.0,
                press: () async {
                  await getCatsOfColony("0");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddCatPage(widget.colony);
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Colony colony;

  EditPage(this.colony);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String valUser;
  String newValue;
  String name;
  String observations;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    name = widget.colony.name;
    observations = widget.colony.observations;

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Editar colonia " + widget.colony.name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width / 8),
        color: Color(0xfff0e1f8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              RoundedInputFieldExtended(
                icon: Icons.edit,
                hintText: "Observaciones: " + widget.colony.observations,
                onChanged: (value) {
                  observations = value;
                },
              ),
              RoundedButton(
                margin: 10,
                text: "Añadir observaciones",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.8,
                height: 20.0,
                press: () async {
                  if ('$observations' != "") {
                    await updateColony(Colony(
                        id: widget.colony.id,
                        name: '$name',
                        locationx: widget.colony.locationx,
                        locationy: widget.colony.locationy,
                        observations: '$observations',
                        cats: widget.colony.cats));
                    await getCats();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ColoniesListScreen();
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Faltan campos por rellenar"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Cerrar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCatPage extends StatefulWidget {
  final Colony colony;

  AddCatPage(this.colony);

  @override
  State<AddCatPage> createState() => _AddCatPageState();
}

class _AddCatPageState extends State<AddCatPage> {
  String valUser;
  String newValue;
  String name;
  String observations;
  String newCat;
  Future<Cat> newCat2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    name = widget.colony.name;
    observations = widget.colony.observations;
    final listItem = cats;

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Añadir gato a la colonia  " + widget.colony.name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width / 8),
        color: Color(0xfff0e1f8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                    border: Border.all(
                        color: Color(0xff8c52ff),
                        style: BorderStyle.solid,
                        width: 0.8)),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    hint: Text("Gato que añadir",
                        style: TextStyle(
                            fontSize: 16,
                            color: Background,
                            fontWeight: FontWeight.bold)),
                    dropdownColor: Background2,
                    underline: Container(height: 0, color: Background2),
                    style: TextStyle(color: Background),
                    icon: const Icon(Icons.arrow_drop_down_rounded,
                        color: Background, size: 30),
                    items: listItem.map(buildMenuItem).toList(),
                    value: newValue,
                    onChanged: (value) {
                      newCat = value;
                      setState(() {
                        newValue = value;
                      });
                    }),
              ),
              RoundedButton(
                margin: 10,
                text: "Añadir gato a la colonia",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.8,
                height: 20.0,
                press: () async {
                  if ('$newCat' != "") {
                    await getCatByName(newCat);
                    await addCat(widget.colony.id, addedCat);
                    await getCats();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ColoniesListScreen();
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Faltan campos por rellenar"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Cerrar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 20),
        ),
      );
}
