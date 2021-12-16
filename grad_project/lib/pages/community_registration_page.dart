import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/student_registration_page.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(
    MaterialApp(
      home: const CommunityRegistration(),
      routes: routes,
    ),
  );
}

class CommunityRegistration extends StatefulWidget {
  static const String routeName = '/community_registration';

  const CommunityRegistration({Key? key}) : super(key: key);

  @override
  _CommunityRegistrationState createState() => _CommunityRegistrationState();
}

class _CommunityRegistrationState extends State<CommunityRegistration> {
  final AuthService _authService = AuthService();
  String currentHeader = "community";

  var _userName;
  var _password;
  var _communityName;
  var _relatedFaculty;
  var _description;
  var _followerNumber;

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
                  isUnderlined: false,
                  state: this,
                  routeName: StudentRegistration.routeName,
                  text: "Student",
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: CustomAppBarElement(
                  isUnderlined: true,
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
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    "Community\nRegistration Form",
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
                      _userName = value;
                    },
                    hintText: "Username",
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
                      _communityName = value;
                    },
                    hintText: "Community Name",
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
                      _relatedFaculty = value;
                    },
                    hintText: "Faculty (Translate it later!)",
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
                      _description = value;
                    },
                    hintText: "Description(Enter a description stating"
                        " that your community has a permission",
                    fontSize: 15,
                    textColor: Colors.white54,
                  ),
                ),
                CustomCard(
                    backGroundColor: Colors.grey,
                    verticalMargin: 25.0,
                    horizontalMargin: 20.0,
                    allPadding: 8.0,
                    child: CustomTextButton(
                      text: "SEND THE FORM",
                      onPressed: () {
                        var _email = _userName + "@ogr.cbu.edu.tr";
                        _authService
                            .createCommunity(_communityName, _password, _email,
                                _relatedFaculty, _description)
                            .then((value) => {
                                  Navigator.pushNamed(
                                      context, LoginPage.routeName)
                                });
                      },
                      textStyle: const TextStyle(color: Colors.black87),
                    ),
                    borderRadius: 10.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
