import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedInputFieldExtended extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldExtended({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    TextStyle hintStyle,
    Color fillColor,
  }) : super(key: key);

  @override
  State<RoundedInputFieldExtended> createState() =>
      _RoundedInputFieldExtendedState();
}

class _RoundedInputFieldExtendedState extends State<RoundedInputFieldExtended> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      fillColor: Background2,
      borderColor: Background,
      child: TextField(
        maxLines: 3,
        style: TextStyle(
            color: Background, fontSize: 16, fontWeight: FontWeight.bold),
        controller: _controller,
        onChanged: widget.onChanged,
        cursorColor: Background,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: Background,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 16, color: Background, fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
