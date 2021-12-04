import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.backGroundColor,
    required this.verticalMargin,
    required this.horizontalMargin,
    required this.allPadding,
    required this.child,
  }) : super(key: key);

  final Color backGroundColor;
  final double verticalMargin;
  final double horizontalMargin;
  final double allPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(padding: EdgeInsets.all(allPadding), child: child),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.textColor,
  }) : super(key: key);

  final String hintText;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
