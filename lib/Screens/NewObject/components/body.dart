import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewObject/newObject_screen.dart';
import 'package:flutter_auth/Screens/ObjectsList/objectsList_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/components/rounded_input_field_sex.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String newValue;
  String name;
  String price;
  String description;
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
          return NewObjectScreen();
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
          return NewObjectScreen();
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if(change != ""){
      currentPhoto = change;
    }

    return Container(
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
                        content: new Text(
                            "¿Desde dónde quiere cargar la imagen?"), 
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
              hintText: "Nombre del articulo", 
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              icon: Icons.euro,
              hintText: "Precio aproximado", 
              onChanged: (value) {
                price = value;
              },
            ),
            RoundedInputFieldExtended(
              icon: Icons.edit,
              hintText: "Descripción del articulo", 
              onChanged: (value) {
                description = value;
              },
            ),
            RoundedInputField(
              icon: Icons.numbers_rounded,
              hintText: "Unidades disponibles",
              onChanged: (value) {
                units = value;
              },
            ),
            RoundedButton(
              margin: 10,
              text: "Añadir articulo al inventario", 
              color: Background,
              textColor: Colors.white,
              width: size.width * 0.8,
              height: 20.0,
              press: () async {
                if ('$name' != "" &&
                    '$price' != "" &&
                    '$description' != "" &&
                    '$units' != "") {
                  await createObject('$name', currentPhoto, '$price',
                      '$description', '$units');
                  await getObjects();
                  change = "";
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
    );
  }
}
