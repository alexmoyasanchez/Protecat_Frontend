import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CatsList/CatsList_screen.dart';
import 'package:flutter_auth/Screens/NewCat/newCat_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_button2.dart';
import 'package:flutter_auth/components/rounded_input_field_sex.dart';
import 'package:flutter_auth/components/text_field_container2.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:image_picker/image_picker.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona las opciones'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    activeColor: Background,
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancelar', style: TextStyle(color: Background)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Background),
          onPressed: _submit,
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String newValue;
  String name;
  String sex;
  String weight;
  String compatibilities;
  String incompatibilities;
  String diseases;

  final listItemSex = ["Macho", "Hembra"];

  List<String> selected = [];
  List<String> selected2 = [];
  List<String> selected3 = [];

  bool isloading = false;
  final cloudinary = CloudinaryPublic("dzkizzrgy", 'Protecat', cache: false);

  void _showMultiSelect() async {
    final listItemCompatibilities = [
      "Gatos",
      "Perros",
      "Niños",
      "Casas pequeñas"
    ];

    final List<String> results = await showDialog(
      barrierColor: Background3,
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: listItemCompatibilities);
      },
    );

    if (results != null) {
      setState(() {
        selected = results;
        compatibilities =
            results.toString().replaceAll("[", "").replaceAll("]", "");
      });
    }
  }

  void _showMultiSelect2() async {
    final listItemCompatibilities = [
      "Gatos",
      "Perros",
      "Niños",
      "Casas pequeñas"
    ];

    final List<String> results = await showDialog(
      barrierColor: Background3,
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: listItemCompatibilities);
      },
    );

    if (results != null) {
      setState(() {
        selected2 = results;
        incompatibilities =
            results.toString().replaceAll("[", "").replaceAll("]", "");
      });
    }
  }

  void _showMultiSelect3() async {
    final listItemDiseases = [
      "Otitis",
      "Conjuntivitis",
      "Celo",
      "Toxoplasmosis",
      "Inmunodeficiencia",
      "Leucemia",
      "Rinotraqueítis"
    ];

    final List<String> results = await showDialog(
      barrierColor: Background3,
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: listItemDiseases);
      },
    );

    if (results != null) {
      setState(() {
        selected3 = results;
        diseases = results.toString().replaceAll("[", "").replaceAll("]", "");
      });
    }
  }

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
          return NewCatScreen();
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
          return NewCatScreen();
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
              hintText: "Nombre",
              onChanged: (value) {
                name = value;
              },
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
                  hint: Text("Sexo",
                      style: TextStyle(
                          fontSize: 16,
                          color: Background,
                          fontWeight: FontWeight.bold)),
                  dropdownColor: Background2,
                  underline: Container(height: 0, color: Background2),
                  style: TextStyle(
                      fontSize: 16,
                      color: Background,
                      fontWeight: FontWeight.bold),
                  icon: const Icon(Icons.arrow_drop_down_rounded,
                      color: Background, size: 30),
                  items: listItemSex.map(buildMenuItem).toList(),
                  value: newValue,
                  onChanged: (value) {
                    sex = value;
                    setState(() {
                      newValue = value;
                    });
                  }),
            ),
            RoundedInputField(
              icon: Icons.scale_rounded,
              hintText: "Peso",
              onChanged: (value) {
                weight = value;
              },
            ),
            Column(
              children: [
                TextFieldContainer2(
                  borderColor: Background,
                  child: RoundedButton2(
                    icon: Icons.check,
                    margin: 0,
                    press: _showMultiSelect,
                    text: "Compatibilidades",
                    color: Background2,
                    textColor: Background,
                    width: size.width * 0.8,
                    height: 20.0,
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: selected
                      .map((e) => Chip(
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: Background,
                            label: Text(e),
                          ))
                      .toList(),
                )
              ],
            ),
            Column(
              children: [
                TextFieldContainer2(
                  borderColor: Background,
                  child: RoundedButton2(
                    icon: Icons.clear,
                    margin: 0,
                    press: _showMultiSelect2,
                    text: "Incompatibilidades",
                    color: Background2,
                    textColor: Background,
                    width: size.width * 0.8,
                    height: 20.0,
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: selected2
                      .map((e) => Chip(
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: Background,
                            label: Text(e),
                          ))
                      .toList(),
                )
              ],
            ),
            Column(
              children: [
                TextFieldContainer2(
                  borderColor: Background,
                  child: RoundedButton2(
                    icon: Icons.coronavirus_sharp,
                    margin: 0,
                    press: _showMultiSelect3,
                    text: "Enfermedades",
                    color: Background2,
                    textColor: Background,
                    width: size.width * 0.8,
                    height: 20.0,
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: selected3
                      .map((e) => Chip(
                            labelStyle: TextStyle(color: Colors.white),
                            backgroundColor: Background,
                            label: Text(e),
                          ))
                      .toList(),
                )
              ],
            ),
            RoundedButton(
              margin: 10,
              text: "Crear gato",
              color: Background,
              textColor: Colors.white,
              width: size.width * 0.8,
              height: 20.0,
              press: () async {
                if ('$name' != "" &&
                    '$sex' != "" &&
                    '$weight' != "" &&
                    '$compatibilities' != "" &&
                    '$incompatibilities' != "" &&
                    '$diseases' != "") {
                  await createCat(
                      '$name',
                      '$sex',
                      '$weight',
                      '$compatibilities',
                      '$incompatibilities',
                      '$diseases',
                      currentPhoto);
                  await getCats();
                  change = "";
                  currentPhoto = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CatsListScreen();
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 16),
        ),
      );
}
