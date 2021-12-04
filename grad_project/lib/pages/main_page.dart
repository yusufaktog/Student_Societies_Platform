import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/student_register_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        StudentRegistration.routeName: (context) => const StudentRegistration()
      },
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
                                      "ÖĞRENCİ\nTOPLULUKLARI\nPLATFORMU",
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
                    Card(
                      color: color,
                      margin: const EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                        right: 20,
                        left: 20,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(
                                color: Color(0xFF000000),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.grey),
                                hintText: "e-posta",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: color,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(
                                color: Color(0xFF000000),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.add_moderator_outlined,
                                    color: Colors.grey),
                                hintText: "şifre",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomCard(
                      backGroundColor: Colors.grey,
                      allPadding: 8.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      child: CustomTextButton(
                        text: "GİRİŞ YAP",
                        color: Colors.black87,
                        onPressed: () {},
                      ),
                    ),
                    CustomCard(
                      backGroundColor: Colors.grey,
                      allPadding: 8.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      child: CustomTextButton(
                        text: "KAYDOL",
                        color: Colors.black87,
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
