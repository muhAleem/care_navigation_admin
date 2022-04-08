import 'package:flutter/material.dart';

class CircularButtons extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final TextStyle textStyle;
  const CircularButtons(
      {required this.text,
      required this.width,
      required this.height,
      required this.textStyle,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: borderColor))),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(textColor),
            // padding:
            //     MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 23.h)),
            textStyle: MaterialStateProperty.all(textStyle)),
        child: Text(text),
      ),
    );
  }
}
