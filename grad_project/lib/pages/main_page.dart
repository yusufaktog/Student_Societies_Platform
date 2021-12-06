import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/authorized_user.dart';
import 'package:grad_project/pages/student_registration_page.dart';

import '../constants.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: LoginPage.routeName,
      routes: routes,
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color color = const Color(0xff4D4365);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: SafeArea(
          child: Container(
            color: color,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      margin: const EdgeInsets.only(bottom: 25.0),
                      color: color,
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 1,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CircleAvatar(
                                backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                                backgroundImage:
                                    AssetImage('assets/images/topluluk2.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                children: const [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      "STUDENT\nSOCIETIES\nPLATFORM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          wordSpacing: 30.0,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    CustomCard(
                      backGroundColor: color,
                      borderRadius: 10.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      allPadding: 8.0,
                      child: const CustomTextField(
                        textColor: Colors.grey,
                        fontSize: 15,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    CustomCard(
                      backGroundColor: color,
                      borderRadius: 10.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      allPadding: 8.0,
                      child: const CustomTextField(
                        textColor: Colors.grey,
                        fontSize: 15,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.add_moderator_outlined,
                            color: Colors.grey),
                      ),
                    ),
                    CustomCard(
                      backGroundColor: Colors.grey,
                      borderRadius: 10.0,
                      allPadding: 8.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      child: CustomTextButton(
                        text: "LOGIN",
                        textStyle: TextStyle(color: Colors.black87),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AuthorizedUserPage.routeName);
                        },
                      ),
                    ),
                    CustomCard(
                      backGroundColor: Colors.grey,
                      borderRadius: 10.0,
                      allPadding: 8.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      child: CustomTextButton(
                        text: "SIGN UP",
                        textStyle: TextStyle(color: Colors.black87),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, StudentRegistration.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
