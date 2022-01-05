import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';

class AuthorizedUserPage extends StatefulWidget {
  final User? user;
  final String type;

  const AuthorizedUserPage({Key? key, required this.user, required this.type})
      : super(key: key);
  static const String routeName = '/authorized_page';

  @override
  _AuthorizedUserPageState createState() => _AuthorizedUserPageState();
}

class _AuthorizedUserPageState extends State<AuthorizedUserPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar:
            buildPreferredSize(context, this, true, false, false, widget.type),
        body: Container(color: mainBackGroundColor),
      ),
    );
  }
}
