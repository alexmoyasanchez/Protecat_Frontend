export 'circle_button.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Feed/feed_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostContainer extends StatefulWidget {
  @override
  State<CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  String text;
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Background2,
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Crear publicación",
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
        child: Column(
          children: [
            Row(children: [
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    text = value;
                  },
                  maxLines: 10,
                  decoration: InputDecoration.collapsed(
                    hintText: '¿Que quieres publicar?',
                  ),
                ),
              ),
            ]),
            const Divider(
              height: 10.0,
              thickness: 0.5,
            ),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
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
                    icon: const Icon(
                      Icons.photo_library,
                      color: Background,
                    ),
                    label: Text(
                      'Photo',
                      style: TextStyle(color: Background),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  margin: 10,
                  text: "Subir publicación",
                  color: Background,
                  textColor: Colors.white,
                  width: size.width * 0.8,
                  height: 20.0,
                  press: () async {
                    if ('$text' != "") {
                      await createPost(currentUser.id, '$text', currentPhoto,
                          DateTime.now().toString());
                      await getPosts();
                      currentPhoto = "";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FeedScreen();
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
