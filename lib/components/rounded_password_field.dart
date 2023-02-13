import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hiddenText = true;
  @override
  Widget build(BuildContext context) {
    
    return TextFieldContainer(
      fillColor: Background,
      borderColor: Background2,
      child: TextField(
        style: TextStyle(
          color: DetailsColor,
          fontSize: 16,
          fontWeight: FontWeight.bold),
        obscureText: hiddenText,
        onChanged: widget.onChanged,
        cursorColor: DetailsColor,
        decoration: InputDecoration(
          hintText: "Contraseña",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 16, color: DetailsColor),
          icon: Icon(
            Icons.lock,
            color: DetailsColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: DetailsColor,
            onPressed: () {
              setState(() {
                hiddenText =! hiddenText;
              });
            }
          ),
        ),
      ),
    );
  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
