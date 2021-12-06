import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/community_registration_page.dart';

import '../constants.dart';

void main() {
  runApp(MaterialApp(
    home: const StudentRegistration(),
    routes: routes,
  ));
}

class StudentRegistration extends StatefulWidget {
  static const String routeName = '/student_registration';

  const StudentRegistration({Key? key}) : super(key: key);

  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredAppBarHeight,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CustomAppBarElement(
                isUnderlined: true,
                state: this,
                routeName: StudentRegistration.routeName,
                text: "Student",
                fontSize: 30,
              ),
            ),
            Expanded(
              child: CustomAppBarElement(
                isUnderlined: false,
                state: this,
                routeName: CommunityRegistration.routeName,
                text: "Community",
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: mainBackGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text(
                "STUDENT REGISTRATION FORM",
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
            CustomCard(
              backGroundColor: mainBackGroundColor,
              borderRadius: 10.0,
              allPadding: 8.0,
              verticalMargin: 5.0,
              horizontalMargin: 20.0,
              child: const CustomTextField(
                hintText: "Student No",
                fontSize: 15,
                textColor: Colors.black87,
              ),
            ),
            CustomCard(
              backGroundColor: mainBackGroundColor,
              borderRadius: 10.0,
              allPadding: 8.0,
              verticalMargin: 5.0,
              horizontalMargin: 20.0,
              child: const CustomTextField(
                hintText: "Name Surname",
                fontSize: 15,
                textColor: Colors.black87,
              ),
            ),
            CustomCard(
              backGroundColor: mainBackGroundColor,
              borderRadius: 10.0,
              allPadding: 8.0,
              verticalMargin: 5.0,
              horizontalMargin: 20.0,
              child: const CustomTextField(
                hintText: "Password",
                fontSize: 15,
                textColor: Colors.black87,
              ),
            ),
            CustomCard(
              backGroundColor: mainBackGroundColor,
              borderRadius: 10.0,
              allPadding: 8.0,
              verticalMargin: 5.0,
              horizontalMargin: 20.0,
              child: const CustomTextField(
                  textColor: Colors.black87,
                  hintText: "Department / Faculty",
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
                  textStyle: const TextStyle(color: Colors.black),
                  onPressed: () {},
                  text: "SIGN UP",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
