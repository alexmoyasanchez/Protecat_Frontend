import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/ObjectsList/objectsList_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/object_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../../../components/rounded_input_field_sex.dart';

class Body extends StatelessWidget {
  final Future<Object> object;
  //final LocalStorage storage = new LocalStorage('My App');

  Body({Key key, this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xfff0e1f8),
      child: Center(
          child: FutureBuilder(
              future: getObjects(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                          child:
                              CircularProgressIndicator(color: Colors.white)));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailPage(snapshot.data[index]);
                              }),
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Background)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              size: 30, color: Background),
                                          onPressed: () async {
                                            await deleteObject(
                                                snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return ObjectsListcreen();
                                              }),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              size: 30, color: Background),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return EditPage(
                                                    snapshot.data[index]);
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: (size.width / 2) -
                                              (size.width * 0.15),
                                          height: (size.width / 2) -
                                              (size.width * 0.15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Background2,
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data[index].imageUrl),
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data[index].name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Background,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0)),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      Size(50, 25)),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(30, 25))),
                                          child: Text("-",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Background,
                                                fontSize: 25,
                                              )),
                                          onPressed: () async {
                                            await subUnit(
                                                snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    ObjectsListcreen(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Unidades: " +
                                                snapshot.data[index].units
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Background,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0)),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      Size(50, 25)),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(30, 25))),
                                          child: Text("+",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Background,
                                                fontSize: 20,
                                              )),
                                          onPressed: () async {
                                            await addUnit(
                                                snapshot.data[index].id);
                                            Navigator.push(
                                              context,
                                              new PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    ObjectsListcreen(),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return child;
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          );
                        }),
                  );
                }
              })),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Object object;

  DetailPage(this.object);

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
          widget.object.name,
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
            Column(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.object.imageUrl),
                ),
              ],
            ),
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
              "Producto",
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.object.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Descripción",
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.object.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Precio",
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.object.price + " €",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: Background,
              thickness: 2.0,
            ),
            Text(
              "Unidades",
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.object.units.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Object object;

  EditPage(this.object);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String valUser;
  String newValue;
  String name;
  String description;
  String price;
  String units;

  bool isloading = false;
  final cloudinary = CloudinaryPublic("dzkizzrgy", 'Protecat', cache: false);

  Future uploadImage() async {
    const url =
        "https://api.cloudinary.com/v1_1/dzkizzrgy/auto/upload/w_200,h_200,c_fill,r_max";
    var image = await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      isloading = true;
    });

    Dio dio = Dio();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
      ),
      "upload_preset": "Protecat",
      "cloud_name": "dzkizzrgy",
    });
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));
      currentPhoto = response.secureUrl;
      change = response.secureUrl;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPage(widget.object);
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  Future uploadImage2() async {
    const url =
        "https://api.cloudinary.com/v1_1/dzkizzrgy/auto/upload/w_200,h_200,c_fill,r_max";
    var image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      isloading = true;
    });

    Dio dio = Dio();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
      ),
      "upload_preset": "Protecat",
      "cloud_name": "dzkizzrgy",
    });
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));
      currentPhoto = response.secureUrl;
      change = response.secureUrl;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPage(widget.object);
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (change == "") {
      currentPhoto = widget.object.imageUrl;
      name = widget.object.name;
      description = widget.object.description;
      price = widget.object.price;
      units = widget.object.units.toString();
    }else{
      currentPhoto = change;
    }

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Editar " + widget.object.name,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                height: 20.0,
                thickness: 2.0,
                color: Color(0xfff0e1f8),
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Background,
                backgroundImage: NetworkImage(currentPhoto),
                child: IconButton(
                  icon: Icon(Icons.add_a_photo, color: Colors.white),
                  iconSize: 30.0,
                  color: DetailsColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Foto"),
                          content:
                              new Text("¿Desde dónde quiere cargar la imagen?"),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Galería"),
                              onPressed: () {
                                uploadImage2();
                              },
                            ),
                            new TextButton(
                              child: new Text("Cámara"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                uploadImage();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              RoundedInputField(
                icon: Icons.shopping_basket_outlined,
                hintText: "Producto: " + widget.object.name,
                onChanged: (value) {
                  name = value;
                },
              ),
              RoundedInputFieldExtended(
                icon: Icons.edit,
                hintText: "Descripción: " + widget.object.description,
                onChanged: (value) {
                  description = value;
                },
              ),
              RoundedInputField(
                icon: Icons.euro_rounded,
                hintText: "Precio: " + widget.object.price + " €",
                onChanged: (value) {
                  price = value;
                },
              ),
              RoundedButton(
                margin: 10,
                text: "Editar producto",
                color: Background,
                textColor: Colors.white,
                width: size.width * 0.8,
                height: 20.0,
                press: () async {
                  if ('$name' != "" &&
                      '$description' != "" &&
                      '$price' != "" &&
                      '$units' != "") {
                    await updateObject(Object(
                      id: widget.object.id,
                      name: '$name',
                      description: '$description',
                      price: '$price',
                      units: int.parse(widget.object.units.toString()),
                      imageUrl: currentPhoto,
                    ));
                    await getObjects();
                    change ="";
                    currentPhoto = "";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ObjectsListcreen();
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Campos"),
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
