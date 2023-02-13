import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Feed/feed_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/map_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:localstorage/localstorage.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    
    final LocalStorage storage = new LocalStorage('My App');

    Size size = MediaQuery.of(context).size;
    String email;
    String password;
    return  SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 140),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "INICIAR SESIÓN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: DetailsColor),
            ),
            SizedBox(height: size.height * 0.15),
            RoundedInputField(
              hintText: "Correo",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              margin: 10,
              text: "INICIAR SESIÓN",
              color: DetailsColor,
              textColor: Background,
              width: size.width * 0.8,
              height: 20.0,
              press: () async {
                await saveUser('$email', '$password');
                await getUserByEmail();
                await login('$email', '$password');
                return Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (currentUser.email == null || currentUser.email == "") {
                          return LoginScreen();
                        } else if(storage.getItem('token') != null ){
                          checkLike(currentUser.id);
                          return MapScreen();
                        } else{
                          return LoginScreen();
                        }
                        //return MapScreen();
                      },
                    ),
                  )
                );
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
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
