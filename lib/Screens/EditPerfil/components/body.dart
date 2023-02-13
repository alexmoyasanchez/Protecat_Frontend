import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/map_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_sex.dart';
import 'package:flutter_auth/components/rounded_password2_field.dart';
import 'package:flutter_auth/components/rounded_repeat_password2_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/Screens/EditPerfil/editperfil_screen.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String newValue;
  String username = currentUser.username;
  String email = currentUser.email;
  String password = currentUser.password;
  String password2 = currentUser.password;

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPerfilScreen();
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPerfilScreen();
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool emailValid = true;
    if (currentPhoto != currentUser.imageUrl && currentPhoto != "") {
    } else {
      currentPhoto = currentUser.imageUrl;
    }

    return Container(
      color: Background2,
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
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await uploadImage2();
                            },
                          ),
                          new TextButton(
                            child: new Text("Cámara"),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await uploadImage();
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
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Correo: " + email,
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedInputField(
              fillColor: Background2,
              hintText: "Nombre de Usuario: " + username,
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedRepeatPasswordField(
              onChanged: (value) {
                password2 = value;
              },
            ),
            RoundedButton(
              margin: 10,
              text: "EDITAR PERFIL",
              color: Background,
              textColor: Colors.white,
              width: size.width * 0.8,
              height: 20.0,
              press: () async {
                if ('$username' != "" && '$password' != "" && '$email' != "") {
                  if ('$password2' == '$password') {
                    if (emailValid ==
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(email)) {
                      await editarUser(
                          '$username', '$password', '$email', currentPhoto);
                      await getUser();
                      currentPhoto = "";
                      return Future.delayed(
                          const Duration(seconds: 1),
                          () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MapScreen();
                                }),
                              ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text("Error"),
                            content: new Text("Formato del correo incorrecto"),
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
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Error"),
                          content: new Text("Las contraseñas no coinciden."),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Error"),
                        content: new Text("Faltan campos por rellenar."),
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
          ],
        ),
      ),
    );
  }
}
