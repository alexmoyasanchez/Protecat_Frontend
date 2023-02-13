import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedRepeatPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedRepeatPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedRepeatPasswordField> createState() =>
      _RoundedRepeatPasswordFieldState();
}

class _RoundedRepeatPasswordFieldState
    extends State<RoundedRepeatPasswordField> {
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
          hintText: "Repetir Contraseña",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 16, color: DetailsColor, fontWeight: FontWeight.bold),
          icon: Icon(
            Icons.lock,
            color: DetailsColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: DetailsColor,
            onPressed: () {
              setState(() {
                hiddenText = !hiddenText;
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
