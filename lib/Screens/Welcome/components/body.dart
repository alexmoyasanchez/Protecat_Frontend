import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 140),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logoProtecat.png",
            ),
            SizedBox(height: size.height * 0.22),
            RoundedButton(
              margin: 10,
              text: "INICIAR SESIÓN",
              color: DetailsColor,
              textColor: Background,
              width: size.width * 0.8,
              height: 20.0,
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
            SizedBox(height: size.height * 0.07),
            RoundedButton(
              margin: 10,
              text: "REGISTRAR",
              color: DetailsColor,
              textColor: Background,
              width: size.width * 0.8,
              height: 20.0,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
