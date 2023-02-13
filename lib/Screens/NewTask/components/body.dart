import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/NewTask/newTask_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_extended.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:flutter_auth/models/models.dart';

import '../../../components/rounded_input_field_sex.dart';
import '../../TasksList/TasksList_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String newValue;
  String newUser;
  String subject;
  String description;
  String date;
  String volunteer;
  User user2;
  String assignedUser;

  bool isloading = false;
  final cloudinary = CloudinaryPublic("dzkizzrgy", 'Protecat', cache: false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final listItem = users;

    return Container(
      color: Color(0xfff0e1f8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              height: 20.0,
              color: Background,
            ),
            RoundedInputField(
              icon: Icons.checklist_sharp,
              hintText: "Tarea", 
              onChanged: (value) {
                subject = value;
              },
            ),
            RoundedInputFieldExtended(
              icon: Icons.edit,
              hintText: "Descripción",
              onChanged: (value) {
                description = value;
              },
            ),
            RoundedInputField(
              icon: Icons.calendar_today_rounded,
              hintText: "Fecha de finalización",
              onChanged: (value) {
                date = value;
              },
            ),
            Container(
              width: size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29.0),
                  border: Border.all(
                      color: Color(0xff8c52ff),
                      style: BorderStyle.solid,
                      width: 0.8)),
                      child: DropdownButton(
                borderRadius: BorderRadius.circular(15),
                hint: Text("Voluntaria asignada",
                    style: TextStyle(fontSize: 16, color: Background, fontWeight: FontWeight.bold )),
                dropdownColor: Background2,
                underline: Container(height: 0, color: Background2),
                style: TextStyle(color: Background),
                icon: const Icon(Icons.arrow_drop_down_rounded,
                    color: Background, size: 30),
                items: listItem.map(buildMenuItem).toList(),
                value: newValue,
                onChanged: (value) {
                  newUser = value;
                  setState(() {
                    newValue = value;
                  });
                }),
            ),
            RoundedButton(
              margin: 10,
              text: "Crear tarea",
              color: Background,
              textColor: Colors.white,
              width: size.width * 0.8,
              height: 20.0,
              press: () async {
                if ('$subject' != "" && '$date' != "") {
                  print("User: " + newUser);
                  await createTask(
                      '$date', '$subject', '$description', newUser);
                  await getAllTasks();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TasksListScreen();
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
          style: TextStyle(fontSize: 20),
        ),
      );
}
