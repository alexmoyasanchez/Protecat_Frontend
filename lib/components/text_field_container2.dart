import 'package:flutter/material.dart';

class TextFieldContainer2 extends StatelessWidget {
  final Widget child;
  final Color fillColor;
  final Color borderColor;
  const TextFieldContainer2({
    Key key,
    this.child,
    this.fillColor,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 60,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: fillColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
