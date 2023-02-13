import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/components/rounded_repeat_password_field.dart';
import 'package:flutter_auth/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool emailValid = true;
    String username;
    String email;
    String password;
    String password2;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.045),
          Text(
            "REGISTRO",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: DetailsColor),
          ),
          SizedBox(height: size.height * 0.05),
          RoundedInputField(
            fillColor: DetailsColor,
            hintText: "Correo",
            onChanged: (value) {
              email = value;
            },
          ),
          RoundedInputField(
            fillColor: DetailsColor,
            hintText: "Nombre de Usuario",
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
          SizedBox(height: size.height * 0.035),
          RoundedButton(
            margin: 10,
            text: "REGISTRAR",
            color: DetailsColor,
            textColor: Background,
            width: size.width * 0.8,
            height: 20.0,
            press: () {
              if ('$password2' == '$password') {
                if (emailValid ==
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(email)) {
                  createUser('$username', '$password', '$email');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
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
            },
          ),
          SizedBox(height: size.height * 0.035),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
