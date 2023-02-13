import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CatsList/catsList_screen.dart';
import 'package:flutter_auth/SideBar.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_button2.dart';
import 'package:flutter_auth/components/rounded_input_field_sex.dart';
import 'package:flutter_auth/components/text_field_container2.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/cat_model.dart';
import 'dart:async';

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

class Body extends StatelessWidget {
  final Future<Cat> cat;
  String colonyName;

  Body({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0e1f8),
      child: Center(
          child: FutureBuilder(
              future: getCats(),
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
                      if (snapshot.data[index].colony["name"] == null) {
                        colonyName = " ";
                      } else {
                        colonyName = snapshot.data[index].colony["name"];
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Background,
                          radius: 30.0,
                          backgroundImage:
                              NetworkImage(snapshot.data[index].imageUrl),
                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              color: Background,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Colonia: " + colonyName,
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
                              icon: Icon(Icons.delete_outline_rounded,
                                  color: Background),
                              onPressed: () async {
                                await deleteCat(snapshot.data[index].id);
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            CatsListScreen()));
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      CatDetailPage(snapshot.data[index])));
                        },
                      );
                    },
                  );
                }
              })),
    );
  }
}

class CatDetailPage extends StatefulWidget {
  final Cat cat;

  CatDetailPage(this.cat);

  @override
  State<CatDetailPage> createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  DateTime dt = new DateTime(0, 0, 0, 0, 0, 0);

  String valUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          widget.cat.name,
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
                  backgroundColor: Background,
                  radius: 100,
                  backgroundImage: NetworkImage(widget.cat.imageUrl),
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
              "Nombre",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.name,
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
              "Colonia",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.colony["name"],
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
              "Sexo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.sex,
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
              "Peso",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.weight + " Kg",
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
              "Compatibilidades",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.compatibilities,
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
              "Incompatibilidades",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.incompatibilities,
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
              "Enfermedades",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Background, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cat.diseases,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Cat cat;

  EditPage(this.cat);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String valUser;
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
        change = "yes";
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
        change = "yes";
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
        change = "yes";
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
      change = " ";
      currentPhoto = response.secureUrl;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPage(widget.cat);
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
      change = " ";
      currentPhoto = response.secureUrl;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditPage(widget.cat);
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (change == "" || change == " ") {
      if(change != " "){
        currentPhoto = widget.cat.imageUrl;
      }
      name = widget.cat.name;
      sex = widget.cat.sex;
      weight = widget.cat.weight;
      compatibilities = widget.cat.compatibilities;
      incompatibilities = widget.cat.incompatibilities;
      diseases = widget.cat.diseases;

      selected = widget.cat.compatibilities.split(',');
      selected2 = widget.cat.incompatibilities.split(',');
      selected3 = widget.cat.diseases.split(',');
    } else {}

    return Scaffold(
      backgroundColor: Color(0xfff0e1f8),
      appBar: AppBar(
        backgroundColor: Background,
        title: Text(
          "Editar perfil " + widget.cat.name,
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
                hintText: "Nombre: " + widget.cat.name,
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
                        change = "yes";
                        newValue = value;
                      });
                    }),
              ),
              RoundedInputField(
                icon: Icons.scale_rounded,
                hintText: "Peso: " + widget.cat.weight + " kg",
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
                text: "Editar gato",
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
                    await updateCat(Cat(
                        id: widget.cat.id,
                        name: '$name',
                        sex: '$sex',
                        weight: weight,
                        compatibilities: '$compatibilities',
                        incompatibilities: '$incompatibilities',
                        diseases: '$diseases',
                        imageUrl: currentPhoto,
                        colony: widget.cat.colony));
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
