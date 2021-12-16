import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/community_registration_page.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
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
  final AuthService _authService = AuthService();

  var _studentNo;
  var _password;
  var _name;
  var _faculty;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "Student\nRegistration Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
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
                  child: CustomTextField(
                    onChanged: (value) {
                      _studentNo = value;
                    },
                    hintText: "Student No",
                    fontSize: 15,
                    textColor: Colors.white54,
                  ),
                ),
                CustomCard(
                  backGroundColor: mainBackGroundColor,
                  borderRadius: 10.0,
                  allPadding: 8.0,
                  verticalMargin: 5.0,
                  horizontalMargin: 20.0,
                  child: CustomTextField(
                    onChanged: (value) {
                      _name = value;
                    },
                    hintText: "Name Surname",
                    fontSize: 15,
                    textColor: Colors.white54,
                  ),
                ),
                CustomCard(
                  backGroundColor: mainBackGroundColor,
                  borderRadius: 10.0,
                  allPadding: 8.0,
                  verticalMargin: 5.0,
                  horizontalMargin: 20.0,
                  child: CustomTextField(
                    onChanged: (value) {
                      _password = value;
                    },
                    hintText: "Password",
                    fontSize: 15,
                    textColor: Colors.white54,
                  ),
                ),
                CustomCard(
                  backGroundColor: mainBackGroundColor,
                  borderRadius: 10.0,
                  allPadding: 8.0,
                  verticalMargin: 5.0,
                  horizontalMargin: 20.0,
                  child: CustomTextField(
                      onChanged: (value) {
                        _faculty = value;
                      },
                      textColor: Colors.white54,
                      hintText: "Department / Faculty",
                      fontSize: 15),
                ),
                Card(
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextButton(
                      textStyle: const TextStyle(color: Colors.black),
                      onPressed: () {
                        var _email = _studentNo + "@ogr.cbu.edu.tr";
                        _authService
                            .createStudent(
                                _name, _password, _email, _faculty, _studentNo)
                            .then((value) => {
                                  Navigator.pushNamed(
                                      context, LoginPage.routeName)
                                });
/*
                        student.add({
                          "email": studentNo + "@ogr.cbu.edu.tr",
                          "faculty": faculty,
                          "name": name,
                          "studentNo": studentNo
                        });

*/
                      },
                      text: "SUBMIT",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
