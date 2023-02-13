import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final int maxLines;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.maxLines = 1,
    this.onChanged, TextStyle hintStyle, Color fillColor
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  TextEditingController _controller;
  
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      fillColor: Color(0xfff0e1f8),
      borderColor: Background,
      child: TextField(
        style: TextStyle(
          color: Background,
          fontSize: 16,
          fontWeight: FontWeight.bold),
        controller: _controller,
        onChanged: widget.onChanged,
        cursorColor: Background,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: Background,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 16, color: Background, fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
