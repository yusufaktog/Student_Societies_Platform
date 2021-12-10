import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.backGroundColor,
      required this.verticalMargin,
      required this.horizontalMargin,
      required this.allPadding,
      required this.child,
      required this.borderRadius})
      : super(key: key);

  final Color backGroundColor;
  final double verticalMargin;
  final double horizontalMargin;
  final double allPadding;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Padding(padding: EdgeInsets.all(allPadding), child: child),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.fontSize,
      required this.textColor,
      this.controller,
      this.prefixIcon,
      this.onChanged})
      : super(key: key);

  final String hintText;
  final double fontSize;
  final Color textColor;
  final Icon? prefixIcon;
  final Function? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onChanged: (value) {
        onChanged!(value);
      },
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.normal),
          prefixIcon: prefixIcon),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle? textStyle;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
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
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class CustomAppBarElement extends StatelessWidget {
  final State state;
  final String routeName;
  final bool isUnderlined;
  final Object? arguments;
  final String text;
  final double fontSize;

  const CustomAppBarElement(
      {Key? key,
      required this.state,
      required this.routeName,
      required this.isUnderlined,
      required this.text,
      required this.fontSize,
      this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backGroundColor: mainBackGroundColor,
      borderRadius: 0.0,
      verticalMargin: 0,
      horizontalMargin: 0,
      allPadding: 5.0,
      child: CustomTextButton(
        onPressed: () {
          state.setState(() {
            Navigator.pushNamed(context, routeName, arguments: arguments);
          });
        },
        text: text,
        textStyle: TextStyle(
          color: Colors.transparent,
          shadows: [
            Shadow(
                color: isUnderlined == true ? Colors.orange : Colors.white54,
                offset: const Offset(0, -5))
          ],
          decorationThickness: 1.5,
          decorationColor: Colors.orange,
          decoration: isUnderlined == true
              ? TextDecoration.underline
              : TextDecoration.none,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
