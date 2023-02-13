import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CatsList/catsList_screen.dart';
import 'package:flutter_auth/Screens/CatsList/components/body.dart';
import 'package:flutter_auth/Screens/ColoniesList/coloniesList_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/cat_model.dart';
import 'package:flutter_auth/models/colony_model.dart';
import 'dart:async';

class Body extends StatelessWidget {
  final Future<Colony> colony;

  Body({Key key, this.colony}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0e1f8),
      child: Center(
          child: FutureBuilder(
              future: getAllColonies(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child:
                              CircularProgressIndicator(color: Colors.white)));
                } else {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      indent: 20.0,
                      endIndent: 20.0,
                      thickness: 2.0,
                      color: Color(0xfff0e1f8),
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              color: Background,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "Gatos: " +
                                snapshot.data[index].cats.length.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit_rounded, color: Background),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            EditPage(snapshot.data[index])));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.pets_rounded, color: Background),
                              onPressed: () async {
                                cats = await getCatsNames();
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            AddCatPage(snapshot.data[index])));
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(snapshot.data[index])));
                        },
                      );
                    },
                  );
                }
              })),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Colony colony;

  DetailPage(this.colony);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime dt = new DateTime(0, 0, 0, 0, 0, 0);

  String valUser;

  @override
  Widget build(BuildContext context) {
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
              widget.colony.locationx + "º " + widget.colony.locationy + "º",
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
              "Gatos en esta colonia",
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
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
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
                    await getCatsOfColony(widget.colony.id);
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

class CatsScreen extends StatefulWidget {
  final Colony colony;

  CatsScreen(this.colony);

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  String valUser;
  String newValue;
  String name;
  String observations;
  String newCat;
  Future<Cat> newCat2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0e1f8),
        appBar: AppBar(
          backgroundColor: Background,
          title: Text(
            "Gatos colonia  " + widget.colony.name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2),
          ),
          centerTitle: true,
        ),
        body: Container(
            color: Color(0xfff0e1f8),
            child: Center(
                child: FutureBuilder(
                    future: getCatsOfColony(widget.colony.id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white)));
                      } else {
                        return ListView.separated(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                      indent: 20.0,
                                      endIndent: 20.0,
                                      thickness: 2.0,
                                      color: Color(0xfff0e1f8),
                                    ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  height: 70,
                                  child: Scaffold(
                                    body: ListTile(
                                      tileColor: Background2,
                                      leading: CircleAvatar(
                                        backgroundColor: Background,
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                            snapshot.data[index].imageUrl),
                                      ),
                                      title: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                            color: Background,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "Colonia: " +
                                              snapshot
                                                  .data[index].colony["name"],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          )),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete_outline_rounded,
                                            color: Background),
                                        onPressed: () async {
                                          await removeCatOfColony(snapshot.data[index].colony["id"], snapshot.data[index].id);
                                          await getCatsOfColony(snapshot.data[index].colony["id"]);
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    ColoniesListScreen()));
                                        },
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    CatDetailPage(
                                                        snapshot.data[index])));
                                      },
                                    ),
                                  ));
                            });
                      }
                    }))));
  }
}
