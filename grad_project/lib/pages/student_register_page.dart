import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';

void main() {
  runApp(const MaterialApp(home: StudentRegistration()));
}

class StudentRegistration extends StatefulWidget {
  static const String routeName = '/student_registration';

  const StudentRegistration({Key? key}) : super(key: key);

  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  Color color = const Color(0xff4D4365);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              "ÖĞRENCİ KAYIT FORMU",
              style: TextStyle(
                fontSize: 30,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          ),
          CustomCard(
            backGroundColor: color,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Öğrenci No",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: color,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Ad Soyad",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: color,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Parola",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: color,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
                textColor: Colors.black87,
                hintText: "Bölüm / Fakülte",
                fontSize: 15),
          ),
          Card(
            color: Colors.grey,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomTextButton(
                color: Colors.black,
                onPressed: () {},
                text: "KAYDOL",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
