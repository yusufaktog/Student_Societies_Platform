import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/student_registration_page.dart';
import 'package:grad_project/service/auth.dart';
import 'package:grad_project/validators/input_validator.dart';

import '../constants.dart';
import 'authorized_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      initialRoute: LoginPage.routeName,
      debugShowCheckedModeBanner: false,
      routes: routes,
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController t1 = TextEditingController();
  final AuthService _authService = AuthService();

  String _email = "";
  String _password = "";
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        body: Center(
          child: Container(
            color: mainBackGroundColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      margin: const EdgeInsets.only(bottom: 25.0),
                      color: mainBackGroundColor,
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 1,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CircleAvatar(
                                backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                                backgroundImage: AssetImage('assets/images/community.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                children: const [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      "STUDENT\nSOCIETIES\nPLATFORM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(wordSpacing: 30.0, fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomCard(
                      backGroundColor: mainBackGroundColor,
                      borderRadius: 10.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      allPadding: 8.0,
                      child: CustomTextField(
                        onChanged: (value) {
                          //_email = value + "@ogr.cbu.edu.tr";
                        },
                        controller: t1,
                        textColor: Colors.grey,
                        fontSize: 15,
                        hintText: "Student No / Username",
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    CustomCard(
                      backGroundColor: mainBackGroundColor,
                      borderRadius: 10.0,
                      verticalMargin: 5.0,
                      horizontalMargin: 20.0,
                      allPadding: 8.0,
                      child: CustomTextField(
                        isObscureText: _isVisible,
                        onChanged: (value) {
                          _password = value;
                        },
                        textColor: Colors.grey,
                        fontSize: 15,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.security, color: Colors.grey),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )
                                : const Icon(Icons.visibility_off, color: Colors.grey)),
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
                        textStyle: const TextStyle(color: Colors.black87),
                        onPressed: () {
                          if (!t1.text.contains(RegExp(r'[a-z]'))) {
                            _email = t1.text + "@ogr.cbu.edu.tr";
                            if (InputValidator.isValidStudentId(t1.text)) {
                              _authService.signIn(_email, _password).then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (_) => const AuthorizedUserPage()), (route) => false);
                              });
                            }
                          } else {
                            _email = t1.text + "@soc.cbu.edu.tr";
                            _authService.signIn(_email, _password).then((user) => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AuthorizedUserPage(),
                                      ),
                                      (route) => false)
                                });
                          }
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
                        textStyle: const TextStyle(color: Colors.black87),
                        onPressed: () {
                          Navigator.pushNamed(context, StudentRegistration.routeName);
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
