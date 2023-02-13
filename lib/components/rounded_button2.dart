import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class RoundedButton2 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width, height, margin;
  final IconData icon;
  const RoundedButton2(
      {Key key,
      this.text,
      this.press,
      this.color,
      this.textColor,
      this.width,
      this.height,
      this.icon,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(icon, color: Background, size: 25),
          SizedBox(width: 10),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: this.color,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: height),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
